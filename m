Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6705E4E7868
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 16:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359466AbiCYPws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 11:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355088AbiCYPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:52:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8E850E22;
        Fri, 25 Mar 2022 08:51:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bu29so14169190lfb.0;
        Fri, 25 Mar 2022 08:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pH8jwkRR2EBSUE876H5S83gYnfy8uK8O5IjEsxRnLlk=;
        b=DNDLfbQoCb/zunj4ZqdeaJuNrYTMjuCDMSvXZSrglNSepFYVmmIbt317vvDltErA9o
         wyPV0MExvHn5YqN2/K8J5ZNRByzWCGo7AaLz02Xa5cORnK5z0USKRdQkMVWOb9IUELPa
         a/2DUW0P+uJMzolyHdKEHGmuasMPe44wOlWVx6rW3v5GYiORiBO/IijYJ77VTwLQ3hOg
         bULoTeB1qxnqwz28BmjRv4SypQmcpgHlmQCdm3PNAAWWBaZrwvUsoxFUP+kEMaIsk9eB
         ppuHH5+0LKb0b9Bin0M0x6Yb/IjhBVX4kx9Eb3wyY4wYZJ7hucbjEh7ewZINAQRxcDBp
         aQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pH8jwkRR2EBSUE876H5S83gYnfy8uK8O5IjEsxRnLlk=;
        b=8OOLieyyH754dgcvzJC+xSjGjOF94tQCKadTszcpcemkNBLnDeVZnwk0FkSKahPGyT
         LotoXfGEe7kY9FJ7cnLTcnywk4S+Ftppp95G3u3HyzRoAr4TQwFQ72c/zjhYntpCfHD0
         PTz34rvXDnOw/LcqtihvgAVeonJEoOJ3zuWTUrwyXhlqw7nTiK3mDuMNPHYf3cEvj/qo
         KhAPflZTKOy5pE8GnJx7UsGCjfJo0yHPvUiXf9nad84HcdIemxsz5JgApCm0UWRBr4cc
         FN/9oqRpm7oeVr9O2T2dVQBF/2on4XmtLBOQ/lbAV68D8Gc3pahdsyjNAqdL21+/N4FE
         PD4g==
X-Gm-Message-State: AOAM533eU3m5Z1OS+GXwNgxFiI9ofRwA28ruxWlzIc7iWgaCnKYpJnZi
        p/srYaJnnvnH8rpeCQ0BsvMmUZf+Q5ZzRpQAc0E=
X-Google-Smtp-Source: ABdhPJw8IWmEFgLYLrbS+ujzLt5zuVCEr0hbSOk5olz5mM3DUEjyefQBcko1zTzzL7inkkp6PgBBIANwN6YoPGmXtV4=
X-Received: by 2002:ac2:4d5b:0:b0:44a:14c9:89fb with SMTP id
 27-20020ac24d5b000000b0044a14c989fbmr8288719lfp.345.1648223470693; Fri, 25
 Mar 2022 08:51:10 -0700 (PDT)
MIME-Version: 1.0
References: <1648170401-6351-1-git-send-email-u0084500@gmail.com>
 <1648170401-6351-3-git-send-email-u0084500@gmail.com> <d2b431f8-9197-4a42-4ee2-4e771e20e0aa@kernel.org>
 <CADiBU39RGQj1-+yK18mZf3MR78KACKqb2kAxkCFKGXKpJ6Nqxw@mail.gmail.com>
 <e4a15ceb-c013-96be-48d1-e65267400463@kernel.org> <CADiBU3-gwsh5v1NLUYr_ovXwpUxQqgR61f-Jpc3G-zHs_yV4uw@mail.gmail.com>
 <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
In-Reply-To: <03999953-77c5-0272-7477-ab8a069b3671@kernel.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 25 Mar 2022 23:50:59 +0800
Message-ID: <CADiBU38zYM1Rw2inTJ_Pu2eWKKqp2Ybb-_+JUJfxfmLNu=kYvw@mail.gmail.com>
Subject: Re: [PATCH 2/2] regulator: rt5759: Add support for Richtek RT5759
 DCDC converter
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=8825=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8811:37=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On 25/03/2022 15:59, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2022=E5=B9=B43=E6=9C=88=
25=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=8810:47=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >>>>> +
> >>>>> +static const struct of_device_id __maybe_unused rt5759_device_tabl=
e[] =3D {
> >>>>
> >>>> I don't think this can be __maybe_unused. It is always referenced vi=
a
> >>>> of_match_table, isn't it?
> >>>>
> >>> I think it can declared as '__maybe_unused'.
> >>> If 'of_device_id' is unused, then in probe stage,
> >>> 'of_device_get_match_data' will return NULL.
> >>
> >> But your of_device_id cannot be unused. It is always referenced.
> >>
> > I'm not sure, but your assumption is based on 'CONFIG_OF', right?
> > Only if 'CONFIG_OF' is not defined, then it'll be really unused.
>
> Is it possible to build this driver without CONFIG_OF? Did you try it?
>
No, my development board always  use device tree that's defined CONFIG_OF.

But theoretically, you can also check of_device.h, if CONFIG_OF is not
defined, 'of_device_get_match_data' always return NULL.
If so, my usage is still right.
> Best regards,
> Krzysztof
