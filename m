Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B3F5A0783
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 05:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiHYDBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 23:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHYDBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 23:01:36 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7159E0F4;
        Wed, 24 Aug 2022 20:01:35 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id 2so17390265pll.0;
        Wed, 24 Aug 2022 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VxfKDuwwNg5yYlLSs0+YdZ24O4j/dNQAe6gY8AbVfm4=;
        b=AGrR5WcFIrZlQ3zV8kT7CcVc12yG+rlWLhwWlJ9nVaeqZo43fNuBVynjl8d/nyiEdu
         cH13xmu7dpNDxX/EzSKlW2k5yU8djpepGguVOlVqg0jGf4F+cmsUXESWaZjksE42AMty
         UhRI61/OfZ5f4INsuq61bi6vzERug/vxG9Q7F6UscBlFHAJVxan7mY6VO17YYl98aRTu
         rPqw6SWkf/JRv3ulmFHBYilK+d529dFoVwQUsXpsgMkQWQvrSJWPyjsNdIkTR8MDll4+
         V5QOGXezxeYuMuUzMFQzS8kzPnNR+P6rvq+Ie4zBqEOoZjx03/pIZas1RCmJqAxCdpn6
         rYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VxfKDuwwNg5yYlLSs0+YdZ24O4j/dNQAe6gY8AbVfm4=;
        b=VK+YZRnmLe3IcITIMlca/LPaaRRRlg9o5AO8f1E14ON1rc3K9RFJGTRFaC4yxS/+rO
         9gYFduULmtpVhge+qmI1KExQG4vURbeHouahH5Sz2Hn6FJpUl1l0eWGl3DY9RshlojhP
         Kj8DMlX+HcasAHHnDajS8f5SvWCoFC5TOe8XEAnk7veK08wMXXgun/M2z3m6n7VPpZTD
         fhLx+I1M0aBK+CTkiNp140YHNupbMIsgeURI69uoyGhos+p+7D+AgoowH/9q3snH6OBW
         8THDapP7QtmcMkVooWhJ7q0qxq3ETWeaa24z5vcUs/2o+1cJ5NWkvFGLnwR/rt8NgLEo
         ndxA==
X-Gm-Message-State: ACgBeo3DSx04K4hAD0+A7xI1Q3ubxIK42TJsA62YDScWX9vhWPqDHu5v
        ndpeEjROKor0gEDUpha7Dlg=
X-Google-Smtp-Source: AA6agR7YfPt6QNzmoXwEbuyg+Xoz9120O1zMM74ZeMOFOmanfpHP008ysz0uUc5NsO5fOeNNVu7quA==
X-Received: by 2002:a17:902:eac3:b0:172:ff31:bb3c with SMTP id p3-20020a170902eac300b00172ff31bb3cmr1738686pld.48.1661396494428;
        Wed, 24 Aug 2022 20:01:34 -0700 (PDT)
Received: from 9a2d8922b8f1 ([116.74.248.208])
        by smtp.gmail.com with ESMTPSA id nd2-20020a17090b4cc200b001f246f2a423sm2176206pjb.17.2022.08.24.20.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 20:01:33 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:31:28 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ARM: dts: integratorap: Update spi node properties
Message-ID: <20220825030128.GA34813@9a2d8922b8f1>
References: <20220312113853.63446-1-singh.kuldeep87k@gmail.com>
 <20220312113853.63446-2-singh.kuldeep87k@gmail.com>
 <CACRpkdafQ4G=a1E=G6GK3W2zAD4Nh96GiQiYbYkn4ctVu3c04w@mail.gmail.com>
 <CAL_JsqJ2p+4R=-HcKJ=UdXFcATrZgwwpfRnJES+-bHxRohorHA@mail.gmail.com>
 <20220815173000.GA45630@9a2d8922b8f1>
 <CACRpkdY2_SC0o-h19+kViBpgMSoBBm_gWv8DqYdzo_h=dOj-6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdY2_SC0o-h19+kViBpgMSoBBm_gWv8DqYdzo_h=dOj-6w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 12:15:17AM +0200, Linus Walleij wrote:
> On Mon, Aug 15, 2022 at 7:30 PM Kuldeep Singh
> <singh.kuldeep87k@gmail.com> wrote:
> >
> > > > This and patches 2, 3/4 applied to the versatile DTS branch.
> > >
> > > What happened to this?
> >
> > Thanks Rob for pointing this out, I lost track for these changes.
> > I just noticed Linus applied ste-dbx change only and skipped others(integrator,
> > realview, versatile).
> >
> > These patches fix clock-name as per pl022 binding which causes no harm.
> > Linus, Any reason to skip others?
> 
> I just forgot to send them. I'll fix.

Ok np. Thanks!

-- 
Kuldeep
