Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72B4BC602
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 07:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiBSG35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 01:29:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbiBSG3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 01:29:51 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58403B2D78
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 22:29:33 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id y15-20020a4a650f000000b0031c19e9fe9dso3345468ooc.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 22:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=A6c6+bU1vwCjSZejst+AnTNuuRlvzLcqyvxpwA2/+DjBNsiT76gcKnGzTn7ldeWElz
         521dUdFa18SZn6azgEnpAmQIHHDBvCNTdLCbwnxDUu4z6xQKFv9OFsuokKJmv+DoYGWQ
         u2j0siY4+CkTsBskPhf5skhROnr7h6nuoCpJYozG/oCQbWosJA9EZjbeNbkski2W7wT6
         6/6cO2kPlxvy1cL9vkjVY2APgoqAOphRe4Xu302qtOKlSH2wMd8xSVyexZ3bwcLJq9G+
         QL9F9qsUMgVgNHtTaNkUT+hm34+bfVJhA/hXqc00VksTUS72GuFQgWBn7Z4+8keJ6oV7
         LywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=HjHwdG0GlwxkZ0D1A0RlpO03nI0muoFMAtHM3UbWjWVahSviB4VhASSAJKy380Z2Ug
         VbSOWFhWLukwcZMiu4ufeCntlrSyS9atgXD8jEfGk+gp2WEBj2iIl7sdL0AenMvMJj1F
         N93hZiV22xq/kbkHJtBFlew1Xcgq505QklCXlVCezbPXrUt6hT35298p/DzYd+lGVXbz
         wPHJuCpev0+mBP81ZPE0xdeCbE0U0oeI4yr3/7hnYBZ7CPSfHx+69U96CKJQ3iRfqoWY
         8tPpPMdaoZfeEvV/2Yz5XTc6QxiSMiaaWCRNQ8gHj+hRhbzFZCEqWubXFYmcgaCBBTVT
         /ihQ==
X-Gm-Message-State: AOAM532NROHnWH5N5Q6X7CwFaKyZEPRnxNA1b2CNziV35c1Q9tsZbnD4
        CWxa7C44TI7/Pa5Y0jV6O7KRDB5lV1RRmZPpc+E=
X-Google-Smtp-Source: ABdhPJz9l0MPWRk0i1AJD5+jiUH1MqXIvIf7jHWWfsNGgcWmY3lhjZriE3clgQkwn/XAA8lFX35v+axgCoBG94rK6dU=
X-Received: by 2002:a05:6870:d88e:b0:d1:359a:29f with SMTP id
 dv14-20020a056870d88e00b000d1359a029fmr5795381oab.232.1645252172535; Fri, 18
 Feb 2022 22:29:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6838:c8cf:0:0:0:0 with HTTP; Fri, 18 Feb 2022 22:29:31
 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <harrykuunda@gmail.com>
Date:   Fri, 18 Feb 2022 22:29:31 -0800
Message-ID: <CAKN7XSVf4XdL+w2fdk58Jqhedo3YXSS9XE-kd5w3Lfg+25yFjA@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:c2b listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1338]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [harrykuunda[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
