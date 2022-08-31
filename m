Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF2F5A7328
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiHaBEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiHaBER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:04:17 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC89B02AD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:04:16 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11eb8b133fbso16477328fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=aWwnYumrQYB1rleXj1VhmPP04qoSNCcEvHW2DQ5dgFs=;
        b=TrgcG+pt7jXylWlLDZvFeapIrFOYXsApglZGDQGhJcxAWoCOyRoE6ANwNX4cOxrxX2
         998Fc1xH+JxJDK6WgORkjzkvf7Nw2uhM8h2ZquKIfblUblaHIQLyJILK4s4JbB5dNT1f
         Nv/RCKe/9JzN0atQZG020t6MuwlH5LBZhFUk2x7RlNaT3XI0fuwqc9ddhXpnt8y+BedU
         CDuVAUCqIlnMJz9k22/qzgAnMyQQuSu4ycIVRsCNBlos+uovk4OoUQ78IbocFeXpaJKD
         PCEt0qh7H/8n1yuiISiU/C79ycrmaBQp1oeNlrX35OxlEDpdr/nYc9tDYgYLU3L9dQOX
         gyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=aWwnYumrQYB1rleXj1VhmPP04qoSNCcEvHW2DQ5dgFs=;
        b=dh82mNwve23oOjEGviq8SaOZDBTdNqOXk4gTFOXTKu3Z8SAlqV8Lb4W+zeMfjOtmeZ
         d5lblLQwkm3boTkCGEpp3fyMHDqz0dTQqMr5bebeObYjc27JL4J6uFgr2TwxRu3alGZn
         7QbxlVFOkLA5KcF0GiYk/Y2nq/M7Ak7s1/DgRsqgjoyvCNUzLG8Y34GqN/G5mSs16zPv
         lnCQSvjDq2NcVXMIXEH3AqIrV0BuwbgYAMEp+3Ch7VuSmtUjsvcQ0QE/BfseLOmjkvnu
         ScYPo40/zNKaUOFirc7Gv6Bv8M/fKW3az0494pzgdQRi62a5GeNFBB5WP7oWMnPGR+51
         kxlg==
X-Gm-Message-State: ACgBeo39BJWJu5BfJI+/xkbLGk4/IJ3f0kATgMS6hWIH1twSa/PSAVgq
        XbA2iGMF1//026mJAH0fmicIaEnyE1frTIZuhWQ=
X-Google-Smtp-Source: AA6agR6EYvjRBKiN+TsRIyORPbhiWvbuYP46l0rS0tyKhLdujtlngh3ofbyWVXnH2vNOyxG5c/dJII7GZ61z/FxshOk=
X-Received: by 2002:a05:6808:2383:b0:344:99d1:1568 with SMTP id
 bp3-20020a056808238300b0034499d11568mr283705oib.167.1661907855717; Tue, 30
 Aug 2022 18:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220830105001.68478-1-wuchi.zero@gmail.com> <CAHC9VhSq7P8oHE5dQXdaYx33yMBFEASKgRngSZyNYMr96UYT_A@mail.gmail.com>
 <CA+tQmHDoGjLsq74cifBpe1LvpN3MKYW0O5J9pX=vh4VVHoir8w@mail.gmail.com> <CAHC9VhSPdD_tJYhynK=a3JcuU-2ez1S2VCUXLu0DJbWCn0-8zQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSPdD_tJYhynK=a3JcuU-2ez1S2VCUXLu0DJbWCn0-8zQ@mail.gmail.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Wed, 31 Aug 2022 09:04:04 +0800
Message-ID: <CA+tQmHD1RDuur7Gt8OP9+gqNs66zb932bOwTzcB_0BvsvzY1RA@mail.gmail.com>
Subject: Re: [PATCH] audit: remove obvious unnecessary header files
To:     Paul Moore <paul@paul-moore.com>
Cc:     eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Moore <paul@paul-moore.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 08:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 30, 2022 at 8:20 PM chi wu <wuchi.zero@gmail.com> wrote:
> > Paul Moore <paul@paul-moore.com> =E4=BA=8E2022=E5=B9=B48=E6=9C=8831=E6=
=97=A5=E5=91=A8=E4=B8=89 01:04=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > >
> > > Hi Wuchi, can you explain what process you used to determine that
> > > these header file includes were unnecessary?
> >
> > When reading the code, if I don't found the user of the *.h in the *.c
> > file,I will think that is unnecessary. For example, #include
> > <linux/kthread.h> in the audit.c, I don't found the use of kthread* in
> > the file.
> > But, I just build that without "W=3D1 " , the after test robot show tha=
t I
> > was wrong. and I don't sure that if it is true to remove some header
> > files.
>
> Yes, I would recommend that you focus your time and energy on other
> tasks within the Linux Kernel.  I'm very happy to see patches which
> improve the audit subsystem, but I don't believe verifying the header
> file usage is a good use of time at this point.
>
thanks very much

> --
> paul-moore.com
