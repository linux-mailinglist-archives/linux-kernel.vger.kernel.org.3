Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D015A2855
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240928AbiHZNPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344005AbiHZNPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:15:09 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8413E30
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:15:06 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x5so1159809qtv.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=mjYhWVFLVXKp0lat09WDhguiwlD9tFRAggvqcDU7H6UeCcWgS+fCiPSTq0qqR+vJCD
         sZJVaKqGxe0Q8YV0h4DZ/7r/l3kStQOYAv1NYrq/qtOX1lNA6oVExMR0vTco8qGCQSkM
         bOpXuBYljDUTzRrMGY9/vFdBEmdlqulvIPBTk7f7zNaR+AU2MbIYhD79oz3kb2gxsGmr
         NH90iqPJey5cUL4KuWKEVOdz2Bw8S2v4boM6AmmVQJ3wsE4Oawgj2tEISKPLjjREBi9R
         CImIwZplG5hezqVhreRbDjYY6P7lVAebUaoOzoRYBsxaOVQp1UrhyWWszv238js30oqw
         qxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=zYikLyUvCow+jgUU0lKCEfcmlWfLvq7Iz4jjC1TeY289P3EgoN+NKw9NR6yU8s0RU9
         2S2PdyXQ1kI97FSzsoI4AHKMxuILWeeJGI8ZO1NLnAGmCfgOvydcs/3oHg86TMKmHTWo
         HzDTl+vHviZPgoGFd201TrjaYJxautfHVGFA5tuoMVd49jSDZdswZpY9HScrWLobNNLs
         Nhhk/vHRFDe35mhsREtg+9AWqip4QPksjzvrmUNwG0aFmcz0AfFdI9rEmtzwqMsvOgiu
         hpXd0xdWuX7o/iLri7wjwrhyVPufrVeCYjQ+PObXw81Zo6ZlFUZZUpT4eV89vcxFvWzf
         /KOQ==
X-Gm-Message-State: ACgBeo2eUwC1f89L9RTw3J+ChCs86ir5duGMKWOhhDCPKrKzIaDn+8qP
        JqlWKsZGI5lVndtbpj49d7wYB2Z2L6XEVsWZlybEc3ZG4KU=
X-Google-Smtp-Source: AA6agR5XyyxJu9bG/TQzzxUbDHZ0R6cxOEpZRTxRYDVsm8hymwWHgLebyOhwS8HTXeD3Y8H/OuhWvYZYIsTmCEweUYQ=
X-Received: by 2002:ac8:5a0f:0:b0:344:63fa:1933 with SMTP id
 n15-20020ac85a0f000000b0034463fa1933mr7679470qta.431.1661519705226; Fri, 26
 Aug 2022 06:15:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:246b:0:0:0:0 with HTTP; Fri, 26 Aug 2022 06:15:04
 -0700 (PDT)
Reply-To: biksusan825@gmail.com
From:   Susan Bikram <susanbikram876@gmail.com>
Date:   Fri, 26 Aug 2022 06:15:04 -0700
Message-ID: <CA+UGmCO=bgu=XUzL21ghfs9buRZH9a9D3xns0+YV6U4M3ufXQA@mail.gmail.com>
Subject: Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:833 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [biksusan825[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [susanbikram876[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [susanbikram876[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
