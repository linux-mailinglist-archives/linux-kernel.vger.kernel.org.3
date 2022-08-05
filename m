Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5222458A8FF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiHEJrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 05:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbiHEJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 05:47:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0760D76474
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 02:47:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ha11so2247730pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=t2xo6E1uDVXBL9rtyALdnKwGeumoPy0aKoIQA7ijnWQ=;
        b=MgkZsXM4hV9EzcfZZeIUMDvNVfe9uC9D/QdN0zFq5uGIqDbVxptUIj68tC//QZ0b14
         v1Cvv5ep+qpOicbLDIyGN80cdODoke7ZjXJcA2ithGLApaKfykoAtxnxux1GvNSg8LIs
         FUCSKfEPB4n0AaFZKdSgn6BNvsowYU6AjJiJNrunFbh3zsL9DfbdsaGluU3pfBmoVK/Q
         WGjcOg1a3EhS50qU3l9p6q7YU1Q2W7woLeP6wxxOXmvLnVaRUwatvzlUGCOaRY+CMuM/
         qIIXO/E6o7eeXr6clWGjKjRQFBB8TYtUSWstsbEJKobEsX9mQ7Bc8Aq3b9zEilqXQaSL
         2MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=t2xo6E1uDVXBL9rtyALdnKwGeumoPy0aKoIQA7ijnWQ=;
        b=2jHhsUA1XDF7nFqGj/xiUSn2NWZbXbyhAHRUYvFQ7z7GqYXJJ+l1wCfpf7bSsRmb0+
         Ks6XxkQicp36uuUIiQgVqT3RlJsCp5NsLy2AbeHdE9hFfJGKG5nikqwHYC7cORjAJERA
         RKnCJVOZt6Z4v1pIRGhH164PSvCsYvp3BLSS6CWTeGdrWN/jkgKJQ2mb8DR88osLkxrP
         S8bukIJbhMJW4HJ9I7mw29FpLFbLAdLW2/WZBofhdfSsnc+lmpluG37pStywNuPP7Sed
         oijsnL8fkyELRfTCwNpmgPSa2KxoMNGqqRbNbVI1InWgw/IjjqJeEWoDZ9fg4duZFg/8
         I/NQ==
X-Gm-Message-State: ACgBeo2FaoNWyODbOjNPKdwusYmVzn6A/sJDOOLNQ0ksBKszjD0PpPDZ
        y5ZkWA4BDscOPxKq1wRLCrcyMDVY3Uuye9KITdjBwQ0qAnTrQZQE
X-Google-Smtp-Source: AA6agR7E/I8artnUFv9E1qBCos4kD/WtesJ92zCOdi1xp8K8MzG0Td4pay3kDLxYRwavkda1zAFtO+RwVgZdRu6W8sM=
X-Received: by 2002:a67:d90a:0:b0:386:a043:2e25 with SMTP id
 t10-20020a67d90a000000b00386a0432e25mr2561364vsj.31.1659692815403; Fri, 05
 Aug 2022 02:46:55 -0700 (PDT)
MIME-Version: 1.0
Sender: idtemy67@gmail.com
Received: by 2002:a05:6124:340a:b0:2fd:b1dc:d642 with HTTP; Fri, 5 Aug 2022
 02:46:54 -0700 (PDT)
From:   "higginsnigel.ceomydesk@barclays.co.uk" <nigelhiggins.md5@gmail.com>
Date:   Fri, 5 Aug 2022 10:46:54 +0100
X-Google-Sender-Auth: cFc_OtioDLN-Io0AFhFU01VamUk
Message-ID: <CAGdTmRt_TXcMB0eau78W9wx3h=dN5uvb5bR_mX_gk0mW2bnTwg@mail.gmail.com>
Subject: RE PAYMENT NOTIFICATION UPDATE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_2_EMAILS_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,YOU_INHERIT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1031 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [idtemy67[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [idtemy67[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.5 YOU_INHERIT Discussing your inheritance
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.7 FROM_2_EMAILS_SHORT Short body and From looks like 2 different
        *      emails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

I am the Group Chairman of Barclays Bank Plc. This is to formally
notify you that your delayed inheritance payment has been irrevocably
released to you today after a successful review. Get back for more
details.

Yours sincerely,

Nigel Higgins, (Group Chairman),
Barclays Bank Plc,
Registered number: 1026167,
1 Churchill Place, London, ENG E14 5HP,
SWIFT Code: BARCGB21,
Direct Telephone: +44 770 000 8965,
WhatsApp, SMS Number: + 44 787 229 9022
www.barclays.co.uk
