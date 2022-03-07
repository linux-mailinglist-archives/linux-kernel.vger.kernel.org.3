Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3292B4D080F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245214AbiCGUBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245193AbiCGUBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:01:01 -0500
X-Greylist: delayed 1812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Mar 2022 12:00:06 PST
Received: from uncle.firstenglishco.com (uncle.firstenglishco.com [194.31.98.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741956AA4A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 12:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; s=dkim; d=firstenglishco.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding; i=the.sey@firstenglishco.com;
 bh=Eylb9VhY/SSMAygF0bYLSZ+CaeE=;
 b=S5Zd5jTSEb5NNNj4T2mFZOFDO9AyRef4vExsqcvySiPgKu9H/PdDqrZ98EAeFcHT5gJz6EmfRhAJ
   1+ZL10PqtLINe5SzIMsGdT8MQ8M90K/Nv/9ukAe1ZUWmYdepbhdbaZhczrcdUrmiyO7U7a+s8dYC
   vw1iunyEyztW4DuHpHt4WoQUo3dmMF/YVwWBkbwgkdprCFDQzxf0Ob2WVdCk3L8s30/ayXzFBl/l
   yve+R5yY6aA9BEfRfGFcRhqpIO95wyjLHFoNq3YeQQsTEOO8vWunHaCOJ17P4aI1w1P0lTfhILbf
   2HiPnZ1I/kPjOn/AMkcMtF6BJtAfO7CmmLpURQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns; s=dkim; d=firstenglishco.com;
 b=iZGuH5KEzU9OJ9naiYtT+rNZb6x/ytcnJCE1pLK1o3Q3wZ7gQn03XO8Ikw75MP99IyBianDA9h0H
   nvmgAyFIBcjEGZKDkfTlThhNsfRdX/M9Q5QEzJewiZx8Zxm/WBBnVwmxQKRFzEdJfhC5CucedNu5
   mgrOsmcjd6SKAFPAwwyNLhu4wQfNacaLB8aIyH2j8oacwigi4sXQ0EfbhOhfHFgGaooIW+sc/TAG
   PHZuI2YS/rT1bdu7W5MLS88eja2xph0saxdULLspuuj7QBII4vDWUFDca6hh8JVsEXd4LsCenPb3
   gV22gdGCLM35Gt5EEeWWxdTf4Dl1LgtYdWZjEA==;
Reply-To: eymencemil404@gmail.com
From:   the.sey@firstenglishco.com
To:     linux-kernel@vger.kernel.org
Subject: 073HSBC
Date:   7 Mar 2022 20:29:35 +0100
Message-ID: <20220307202935.943A14D016704E75@firstenglishco.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_DBL_MALWARE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.5 URIBL_DBL_MALWARE Contains a malware URL listed in the Spamhaus
        *       DBL blocklist
        *      [URIs: firstenglishco.com]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6871]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [eymencemil404[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings linux-kernel
=20
Good Day. Hope you are well.
=20
I hope my message finds you well and healthy? I am contacting you=20
due to my recent discovery in my bank branch and a profitable=20
proposition for you. I will give you more details regarding my=20
proposal when I get your reply.
Thanks for your understanding.
=20
Best regards
