Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6E565E12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbiGDTfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiGDTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:35:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75FFDEEA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:35:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r9so12093706ljp.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=AOuJfDK+0QwtZ/uvgMV5qrF7D2aVWD/S//Bu+xTDlNs=;
        b=OdjB0AOVDcE9TW+uNU6d1i6JMWx35VYQBAcL3SKmSlOYM7tziKMIdeCRoIMG8bSmMY
         tThPT1R54C8+WBMk55IrbrRCNQTZ/1rGtsODJ4v69eJaXrGwCKBPz1b5k7aMrm9ykqGr
         lcqC9q2Qti0PJTkvsYPEeSMdRDiYPpjclFshcWKUtqsHbW3H1VwDgrLbYXFBSU2lTwhJ
         PInvpAB6hf0oGt6r6RfPwBKyB4VYCXiHD/pC6DVvXhw2cKN0rJVlmBWwYO7XW70+pbNo
         UjX5B4IWLN8ejl7hYdnz/VMcf/tK2aXigzcTQZCwYAcdQ83MViZLMIQhkK6YuNdE/rkR
         FyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=AOuJfDK+0QwtZ/uvgMV5qrF7D2aVWD/S//Bu+xTDlNs=;
        b=bTmgxqCQGsEKeC/B3GGU/WxcL2XGXjLHZFeeCp7MVHHVLLIuhXaAo1H/HifwTc4E2z
         NmLrHbH4EaA1buqRdoODt5m1J+faZjj4yLwDvDQK8FOiqg12UPksfxfiFUvJkQxammsp
         HmgxPsTcFHlFDX6fjXPlSLhbo4ocuzZ0K+cgT800Ipq57jxuXmlHPLNjWw8lPVNXYZJq
         1s6V+hjWocBrPHM0YkKGqiFy5WRsDyczx6Z16q+FxuSJlJEhaVgXi+2FprrkINhc316d
         njkP0tWO3xkSb/Nx+Ora3qXX86s36JGHXQjN0sBBovKYPItFMbbaOWmg+9nOA4/KKsV2
         QFwA==
X-Gm-Message-State: AJIora9KWXWpruaf5sRNa8u2Z7/upiZ53A9L/Q72lIUAQw4NXFfMK+wB
        Fcu8sJx9WT3IYt7mdlt7I0dPvwlgZtp+RGLvkGg=
X-Google-Smtp-Source: AGRyM1tNcUEwSn0Hy34eReFTIAq8Pm1pNQ8TsGLATZj75rFQX8WSUdBVTRF5s4F2kN/LSvhQ5KyGTTsbjeFK3T2WOfw=
X-Received: by 2002:a2e:a236:0:b0:25a:af3c:5c66 with SMTP id
 i22-20020a2ea236000000b0025aaf3c5c66mr17942916ljm.30.1656963347838; Mon, 04
 Jul 2022 12:35:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:a54a:0:0:0:0:0 with HTTP; Mon, 4 Jul 2022 12:35:47 -0700 (PDT)
Reply-To: nikkifenton79@gmail.com
From:   Nikki Fenton <gloriaphilips764@gmail.com>
Date:   Mon, 4 Jul 2022 21:35:47 +0200
Message-ID: <CAH46Ot9kUS5jGMDooOO7G5-RNiv5DmyUez71PFGv4RKZb6JM-w@mail.gmail.com>
Subject: Please Read
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I viewed your profile on Linkedin regarding a proposal that has
something in common with you, reply for more details on my private
email:nikkifenton79@gmail.com

Nikki Fenton,
nikkifenton79@gmail.com
