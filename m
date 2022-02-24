Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C8F4C2254
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiBXDXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiBXDWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:22:55 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC29B131113
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:22:26 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so1306318ybk.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/WC7HTRELV/OnLen1c2rD72XeE/g93MkRb1iUbcoOPo=;
        b=XFm6pGH8KD3m9dJtb3wLNAa75Ob2CQ8IJZ3xyXsLAOWjgBWcQ99+MaYXF3hF2aMXeI
         a8wbeJS5f2wNPu5dbMB0MuS3Nh/emuwF+IvAhYr2hxqGhO+birLHcPwDgB85vKDAMMl7
         uOZUbqGlCdcdY4ESDgsxYa4PGZ60xaEr8pGi37OJWWKl8NxhM6MP2Ek27cWLpPRqCbZq
         P2q9UpH950X6Rez55k3/fobbvwEW+lYilx6J+CfuQgSBCix04IsqdFF5iizia0qpjIho
         V3GDLg8aYU84YCxWn6vWqFGHJrpQItlHnbhy96Dvr/tSv3zX5TtZ6JodtCKX4eZBfNAT
         xjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/WC7HTRELV/OnLen1c2rD72XeE/g93MkRb1iUbcoOPo=;
        b=mHre6L1k5KdMFA0OgcOAuNjbXLj/n3B7HvHriTdkHSqRjSYBOprkQ8fkdLv4/CN/Hn
         27HodMk2Y3wnTnWWAWpPkWOYroKwNgtC+gB2SsKCmxriJOfiY/79Wg9IWqSw5j3VS594
         dFNT7Tiw8ZLPq1EOYWtJTpqGgy8TOBfUB+G/4d6XvXvqGUJtTTU5KIEl4+DOuAjaV3Ql
         UZqQ6DqigpzI5Gtzh+eJkURY48QAmyUHsLc7Dd0L3MCXXVAs7on3YGRFPZEDSyIbeYnX
         jVW5xfR9Heasqe1k8x/cwlhrNjFQPTK0wUJjoBefG3VfXR9pRxLrL5z1EHYRiHUo5Tg8
         l02g==
X-Gm-Message-State: AOAM532J6Y4vohf/JeEkGsCPUvvj7kR0G0KbLDJuSoRGnWjRQzAvILzu
        MzTV9arwhk2/epRMwNjFQD5yulfTlkPbG8eLddA=
X-Google-Smtp-Source: ABdhPJxdnMVuMPy/5vuQA1CiFeoB/f1hvfDhTIfrfVGRcpBXSltZbgV6oSv2n9DX2eZsHcM2rkH8iJBIHrP87RTV05w=
X-Received: by 2002:a05:6902:284:b0:624:1c25:cda1 with SMTP id
 v4-20020a056902028400b006241c25cda1mr718518ybh.480.1645672946270; Wed, 23 Feb
 2022 19:22:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:607:b0:127:200:98ce with HTTP; Wed, 23 Feb 2022
 19:22:26 -0800 (PST)
Reply-To: j33ciss@hotmail.com
From:   Justin Cisse <dri001ed@gmail.com>
Date:   Thu, 24 Feb 2022 04:22:26 +0100
Message-ID: <CADx1BfHQN5tpGQC-3gbUB7er3s6a5=hDZegecCHkCtt3gA1ECA@mail.gmail.com>
Subject: TT:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
I seek your partnership in a transaction business which will benefit
both of us, detail will be disclosed to you upon response.

Best regards
Mr. Justin.
