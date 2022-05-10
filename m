Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08BA522445
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349040AbiEJSm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbiEJSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:42:50 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9C82A1523
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:42:49 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-edeb6c3642so65772fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 11:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=fRGYlsYtKjeR7SLxK1Q/hlnVkvMCL7nW7++KYx2qsUr3ufQPpRKNDcItNb3XFZKlmj
         LH7gI8/D/i3Afzj5hiM/wmaKdgdZFQQsfE4GK+XNsMXLU2UlbKLo9OgXOeLOgwt6V9Wj
         cD56tNDF7rIpRVKCjOVD12frZ0cjULQSjgU5qPNiZ+n7ZlLyvOK2s+gsTHoN1xtArW+a
         YUxLIJG2dcBR8tmQqsXVV6RlKQb5QMDQilX3/I9aSkDwc30fnb8UZXv1SiXdoHHv10fO
         zM9EAuZ2Co+cHP9Y+lFIkzix6CMIWbRJSbNatyaod0I28DraoOS+bFRVuTdJEB0YTvyd
         SkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=2povo/0hjHbtypL6IIS/pUvlq7B88qiKgD0ZSLx0nuAZHYcolMjjsYOCQ6PXJo8R5p
         pmly/75OMf+4hOUD5Pl04oZqmqe84FSMcsXrCoM1kNQNFYGlsH2tXSRYmEFszKjB8W/C
         KS50J8kLFiAw96ZVU84XtS6Dxe3lesx2fAw9Y0EmDu3JbPjY1y/MMVygtclP2OMwDqMr
         b/4fIf4Yq+fyt5P/d2m+1V/nWw00FjIJafJflLwTxAVPJBe0anxL7TF08k3LNtZHdD/M
         tU5MDZhRukYnUdUXWEYDgLYrNGpM0SB6YZplZmQw5t2MDuGP0zcJIkdaSLORxSxvAkyB
         Ob8Q==
X-Gm-Message-State: AOAM530ihQGTONOCn0zqQON+nDpOP544jkSqZcfQ83IAveK2aP644xhl
        /cP9CkSASjcEymCWMVwnSk+NkQwBnbzEbtFrOuE=
X-Google-Smtp-Source: ABdhPJxaTBiMWx7mUrvSuhCxru3ZMoNKmOc1CKeeHpMWZTa13yrxLkNqcJnqbAU8R2tIoA5usw9ktgSqolq95aaKoj4=
X-Received: by 2002:a05:6870:d59a:b0:de:9ec0:8f07 with SMTP id
 u26-20020a056870d59a00b000de9ec08f07mr846671oao.15.1652208168441; Tue, 10 May
 2022 11:42:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:52c3:0:0:0:0:0 with HTTP; Tue, 10 May 2022 11:42:47
 -0700 (PDT)
Reply-To: avamedicinemed3@gmail.com
From:   Dr Ava Smith <tracymedicinemed1@gmail.com>
Date:   Tue, 10 May 2022 11:42:47 -0700
Message-ID: <CAOHAJ295wV4_9vczhLvNpTKDnQNf9McO5=pWBYtzjqzaosod8w@mail.gmail.com>
Subject: From Dr Ava Smith from United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:30 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [avamedicinemed3[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tracymedicinemed1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tracymedicinemed1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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
