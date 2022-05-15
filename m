Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2475279A9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiEOT5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 15:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiEOT46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 15:56:58 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AE5389C
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 12:56:55 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h29so22669122lfj.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 12:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=O5ZKIc3Cdpl730oRfob2eckmF/zaDsm2h3/TseHDgmkrgBCRAsrnfEgQY0fW8W8cQK
         4oraOJQaxbvSHr34hMrhtkg6zOx7e+nkBzCD0YEVn5qUsjwXGZjYEF1cv8mgZxvwfITI
         bKHjlg+r6NCM9jbLzSv2uT/7Z/kZFtD+0nBXhCmlEfvGNDUAJPgunQLpUJ8DoRaAVsx7
         150yc3oWZrdgfkxbLDUTjSZuGQP5D4ZZN3ruxRVjpSta7FPW8KtdcpCchLpWjFRxiHnB
         OTGptZmaN2w+jvnxwGrpOR8dpmg7+NnRnVe4IexV4G8xtMY33NoSiVXFXjg6SO/KbsP8
         c16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Lb6/QJm8WfTEQM4jSY3FYFFigmls8EQzosjN1wbj9PcWXhPEZKSH06B/RXZ/qh+VOh
         VleZEEgk7i+4A+aJZ6L+l1ZF3nQEpNj/c8AlGusmaYCRFYCN0iDw/MjiXWVRflDYfx//
         WS+bfx0Rr/CjKHlS6tgylGX0SIUb78R9voGPK74qK/zEIMJkHQXxjmPyp8/7jAFjG6cH
         Ua43bgWLQSLxx3p84Xhn1OfWjktBX2VKUtp2rYgO08Yd2UB1PfM5e4UBqjTS1oFB2Xh6
         NpVZSD4Rn3dlVnxnVbger/U8Te8ZYSkHrLFmXL4VSd/xTKuZ2GPibYtqkpEszaUpj6hf
         CoDw==
X-Gm-Message-State: AOAM531LJZdBz6HlfSY2Y8NgqWgZP6Lesd5FHbW/xeL5kI88IjqDkdUM
        6QwwSL+q7sXMmqwsAyD52yq+TypYMTJXePwYj6I=
X-Google-Smtp-Source: ABdhPJxBH4GXAsPzVsmedM1LGIE15mm+bcw+GGeEyGkU2u8FMo6A0GHo0WCqsaMDrPmI1aDRLk164+amt8n04tomMGQ=
X-Received: by 2002:ac2:4ac9:0:b0:471:f6da:640d with SMTP id
 m9-20020ac24ac9000000b00471f6da640dmr10644380lfp.286.1652644613581; Sun, 15
 May 2022 12:56:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:44da:0:0:0:0:0 with HTTP; Sun, 15 May 2022 12:56:52
 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <raqsacrx@gmail.com>
Date:   Sun, 15 May 2022 12:56:52 -0700
Message-ID: <CAP7=Wk6w5O5fgfAk1tCwUxW2OL277jak+UgW7m0iOVYZiLXDAA@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [raqsacrx[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.4 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
