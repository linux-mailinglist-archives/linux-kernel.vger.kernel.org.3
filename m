Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F8A512D47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbiD1Hsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbiD1Hsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:48:43 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAC727CC1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:45:29 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id f32so3890980vsv.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=aVlRD9lVje9JINa+B701E819D54LSeS9zYTCXY91YkvddZCI6cpTXoV9o5CUTEspMQ
         bPxpMr3n9DQpLcappkOsUcGa5x1Fc3Qe6dn2XXG2yaPYsMlyhcJspbpLbXFkYHOgbMwo
         gIcyS006w/9sN5KJy0FUj0eemCIuo026Z9DBhfYtSusS3M12p2k8yW0MWVDADqowWU4A
         i3ZxvgNI0uT65mCE3SeSyOyVstdQ5mf4/ErWFs5/NpVmPd7hkpmZ6d3AlHXsCNd22wX7
         Y7IK/vwbyVzBeCSlo6DZXUe2wQSZiMnapYitlL9oKZjzV7hLB+ln1BDjWuGGCib0XDci
         oFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=NLijoYwk7hqoA8TsUJbQbQCYzScrvalH7Lc8MykkZrA=;
        b=HBRLuGiKdrEnQLHx81IIwdY349VrT6/27jP88X10FF+hO7rVpJy9987BiOJebRlcRs
         AOBZsFogYOtVIRFRtzK+WQ2DyM2J1TyMCDR3Mfka59RBRB/1xAaAeS23SrUboSidaIib
         /Y8FH9pluco51xnci6ka/yIhvTqzgpyRQpT0PxbH1XRQi9CjvQdED2vU8gyc+DNqJRuW
         Y8tcQ+B+s16NGlmWSz3e68/XtLFM+Jb0mq27SXR7RYfJYuLxnfQO1nGUEkDiXE+s0E5A
         JDQqBJGnlilCfJeoVW/XHQSjFdf3SiExB/1n2BhSZLZs8LmXdG/7Vs4jm8ScB/0qZGTf
         Mn+w==
X-Gm-Message-State: AOAM531ee4f/05Xzl3GMb6Md/HGTqet976IW9ExiXL+nV4itAB0dKH0S
        tXXs6nfU6kO2ttUsSnfJukR3dkHxhn9rCYCi/A==
X-Google-Smtp-Source: ABdhPJybXVPCWs98j08Hfqig3naSQ5jnbepESY3K0fZx/Rr8JrRX9CSegA/eC0k40UmJtMhGXvcqadGnUEor26bPhJc=
X-Received: by 2002:a67:f6ce:0:b0:32c:dcb9:3857 with SMTP id
 v14-20020a67f6ce000000b0032cdcb93857mr5754240vso.57.1651131927957; Thu, 28
 Apr 2022 00:45:27 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: mwibergcaitlin997@gmail.com
Received: by 2002:a59:cde8:0:b0:2b1:df2c:6127 with HTTP; Thu, 28 Apr 2022
 00:45:27 -0700 (PDT)
From:   "Mr.Sal kavar" <salkavar2@gmail.com>
Date:   Thu, 28 Apr 2022 07:45:27 +0000
X-Google-Sender-Auth: -8hZpBjJiXJ3DWgyGT5K5kLykKg
Message-ID: <CAOw4te0Y8Rp4hrcHwH0oK6Qb8vdEFE+5d7yOU_8C10gsKSseYw@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FRAUD_5,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health. I am the foreign
operations Manager

This being a wide world in which it can be difficult to make new
acquaintances and because it is virtually impossible to know who is
trustworthy and who can be believed, i have decided to repose
confidence in you after much fasting and prayer. It is only because of
this that I have decided to confide in you and to share with you this
confidential business.

overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason, I have found it expedient to transfer this fund to a
trustworthy individual with capacity to act as foreign business
partner.

You will take 45%  10% will be shared to Charity in both country and
45% will be for me.

Yours Faithful,
Mr.Sal Kavar.
