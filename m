Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417244D2E83
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiCIL7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbiCIL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:59:02 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93D92AD2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:58:02 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w7so3317923lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 03:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=XN26NyJ/ne8cQKGXg7h+XP3te8sRxLxnlGU8Aj8COAncPtISD/eizumgSJDLmOqc9J
         0D9KlJTBUkEebllu7lbXXkGNRo7BpdP7gMm/E3z1Eh6Mn5/0ZDSol32G3xpKttfPebbI
         +8Ox3tSFMzMJG+Ls6VtKUPkFtEEhV9t7XUO1qAX+zkjWj+hGK654TTbmjIXdiyXGAN30
         8+WigSLGe8e9tQVG+cPphBec1W6XI3YJpHA1y69wYuoV2Plau40BZbzPRT3TQOc0VLwd
         txS7iyIULp5XOsH7aSgUaka4uYWIF9JmRT/wgdUFWzeIlibdmEKA2VXF4mDWlEoZRjvx
         i1Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=y/WwzOufdV8bFjC2XhKxeIddPBCZMNKZVHLfMOMvj6I=;
        b=CHjArE9yUGlMMrd5k5DNaUz0rkQzI0m6hM+sdTBIu4k3ReBMKFlzdmWhr6jhnvxEEP
         Ut9qJaSAJN688hkevV3o4WeVzf+EEBRCZnY1Cze98Ad4ExFfgEgleGLaeyAlL8vQwqM8
         /dE6c+n4YtSPKCE+urCyq4hCJU8l87NcE5+PMLKsJzkRjACT6v4OEVADoqJ8E3ck9rQY
         ZayswdQObYKAO0SDXZQojlm+/nTiic4Y9REzczVEU7Gqol4HRxP+IGb3TPRqkc3ggvlP
         vSrRL8etbvhn4bQhLI3LatwAHF8h6Y0l2i1Qw1NMhiZEj8Qp1gbtRQhCCGApAWcla+dV
         t2Hg==
X-Gm-Message-State: AOAM530erwx7YRprW/Ly3VagyhF3QEO+oYi6TeveCYxx+Rbze1jZrAob
        9NgpHeucqxrOphBWtx4DkSKcd4oyedoI5/MMfds=
X-Google-Smtp-Source: ABdhPJyyAMTCTtpTvFc8CBhdOYJLvYI+RYExlAmV+5IzQ6XkgcT8gYi9ujciFud5Xewgrr9bOoF3AJVk+IoMuGF/PkE=
X-Received: by 2002:ac2:41cf:0:b0:448:3116:3aa5 with SMTP id
 d15-20020ac241cf000000b0044831163aa5mr8808169lfi.660.1646827080942; Wed, 09
 Mar 2022 03:58:00 -0800 (PST)
MIME-Version: 1.0
Reply-To: drtracywilliams89@gmail.com
Sender: somaabdelgader24@gmail.com
Received: by 2002:ac2:52b4:0:0:0:0:0 with HTTP; Wed, 9 Mar 2022 03:58:00 -0800 (PST)
From:   "Dr. Tracy Williams." <drtracywilliams086@gmail.com>
Date:   Wed, 9 Mar 2022 03:58:00 -0800
X-Google-Sender-Auth: 9HNm3f8XU-44hTT0I4Ruv_xfxWc
Message-ID: <CAFkJkpmrA-oV=7ejAuCpWZx4oWbB1c=5NbELw0oEPoTtsLmvfQ@mail.gmail.com>
Subject: From Dr. Tracy Williams.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

Hello Dear,

how are you today,I hope you are doing great. It is my great pleasure
to contact you,I want to make a new and special friend,I hope you
don't mind. My name is Tracy Williams

from the United States, Am a french and English nationality. I will
give you pictures and more details about my self as soon as i hear
from you in my email account bellow,
Here is my email address; drtracywilliams89@gmail.com


Please send your reply to my PRIVATE  mail box.
Thanks,

Tracy Williams.
