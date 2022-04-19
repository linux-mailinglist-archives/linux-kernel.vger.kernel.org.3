Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0048250794A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356840AbiDSSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356949AbiDSSbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:31:44 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5621419B3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:22:38 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id y129so6243888qkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uM6URlo64vnwT75675dXokv0If7L93kTHHH/DSCpiRA=;
        b=p5pblPpvv/dx+BYsJ0n/CU+vZGLz041NM4OHGR3IOFAJr2tNP7tnDoYqG2Hmavhfq+
         TPH+XpDFtFcRNlrn+WnrFkhUQuPwaemAAm8du0tUB9fXniHmfaxN//jZ4U25mxci9xFJ
         rfnJMXBzqE7KzLDcqpXZWHYikpgMVCM80IxdU2og3/rfcpInlcCMZgA3xyY1GFR5+srV
         DRSjgJgk717ezoVhByaiAk4iEz1/YQnJ0ljWdB3W35WbUw5vE2Nl3fXrablTcuackhfu
         r8Eq8AU94Of1Sld5lXdf7AEXyY+toRtscrAWY1SF/hvior+w19ycCwiCauMGlgYwXpeg
         CUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uM6URlo64vnwT75675dXokv0If7L93kTHHH/DSCpiRA=;
        b=e3BliVzjGRkMjIcjRH0X2NomXs/5U5DGa+F844TCjRy8TPoI8yJOm4jzTQlSAu/1qG
         GJG5hx7A5DhjBkKBw9XqVu6/mD7udB9HxXMdRYL9j4PNc3dV9a9/N9CPzCQF4DW3TqWp
         jIcEu6zfXKwklLBpJHv5/FNfxnwhuZrKUjdai7/3FL5NpD4c4Xh7q5N1Hou7SBavO0fk
         cGcQJVsgIji2wokHUvs785azZGNIrMjjkHYSGndAHFz+eUK5X0LGEqzAVok7ByqMTWn7
         VKM2w/SuO9lfqHEvilHcKICjzLi1Mp5R+qV2kkI8z9V83c1jS7hJVi82YRYWS01z1nsw
         Ph6Q==
X-Gm-Message-State: AOAM532yBm11NSsKhJBsKvd9ibM/FJvtJuIBdug5pkxeZXd8y/3kesIG
        PGAVbRw90C9KllcRCFuujKEwjlmSCsROXjh/kWZbIM+s
X-Google-Smtp-Source: ABdhPJwEmH+FhLPpk7EiRdNdOXL4ysHgnCorcXqTqHB1jkWn107SpWCjumv1tTCp1XUVJ2Di7M3p0yFIt80KW8d88Co=
X-Received: by 2002:a05:620a:2804:b0:67d:1e7b:b528 with SMTP id
 f4-20020a05620a280400b0067d1e7bb528mr10454138qkp.193.1650392556242; Tue, 19
 Apr 2022 11:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <5ae22b2e-97de-6680-50a3-887ab87b3b87@gmail.com>
In-Reply-To: <5ae22b2e-97de-6680-50a3-887ab87b3b87@gmail.com>
From:   Jeff Kirsher <tarbal@gmail.com>
Date:   Tue, 19 Apr 2022 11:22:25 -0700
Message-ID: <CAL3LdT4gohtJk7s2V1j+_KhL_NuWg6_siJiaFQuELFL=ODnHzg@mail.gmail.com>
Subject: Re: kernel LAN : Intel 2.5GbE LAN : support
To:     hanasaki@gmail.com,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 8:39 AM hanasaki-gmail <hanasaki@gmail.com> wrote:
>
> kernel LAN : Intel 2.5GbE LAN  : support
> Intel 2.5GbE LAN chip (2.5 Gbps/1 Gbps/100 Mbps)
>
> Looking at the below motherboard.
> what .config option and kernel module supports
> this ethernet LAN chip and at 2.5GB?
>
> What is the first kernel version having support?
>
> ref:
> X570SI AORUS PRO AX (rev. 1.1)
> https://www.gigabyte.com/us/Motherboard/X570SI-AORUS-PRO-AX-rev-11

Adding intel-wired-lan mailing list, which has all the Intel wired
Ethernet developers to answer your questions.

-- 
Cheers,
Jeff
