Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9899355A3E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiFXVtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiFXVtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:49:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8554D87B56
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:49:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k127so3612631pfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OZTnn904cGbOAF5rFW+CqzP10VgOzvWMTEoPdfcE1ZA=;
        b=J8J5m7QD00jSZDZ0ED7mfv3m+RSX7WzclJYctgKeMgbTwj5OPmNyubLG/W83dcIaNi
         AZBF2R7XQEBkB8wB6JCuQCFZjpYecUBlsZquG2GOUBAdYO7O/2nVBUQJ8bPoy3YHeBWR
         KlB0zcxsRbZKmuI9qIOruXhhocnL/suPUhEYenoDsJc4wmSE2tKiwPTn/dWbMwq+V8aB
         qMg0zGGuEWPWj8dNXgVIbWjVJs6MkPAuOU6r1rGquucCLDtAjtzFpOz/mMjwID7yvffC
         9gqOPmxwM6gRh1EtjIm7MRVuZiboP6jYCvN+r5ypGI3JyUfuqGctgJnMDpQXI2Y16OUa
         2FCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OZTnn904cGbOAF5rFW+CqzP10VgOzvWMTEoPdfcE1ZA=;
        b=LZjDX3/O0WNe0M2Y6DhR0Q1sVTb6dpzWjegZUs+zuFGRFxf+BPnu/TB36SdhvrLU4N
         +j2+0WyBRlp+nW0fkRAGU962XrVPg6Xljwj9Me7hTJFIRrSFTOCkGqVK7S23r+U3dQCt
         PevrqVMv3S5UAcVXy2ZZ/xeJcgeUXaThH8cOrFbHHChXWfEqVeHyQ3aPiHKkXNqaIJ2K
         6ZwgAbX+hsc0qjV5aJlrM/QgC7U5k64dn2VzgKc4RHhR6iUNSk9AbhifTFoDZYu4a35u
         DYcaj+wKiSsz0CNCC/T0cuYYxvrugPOW1EAbb4eymY5aq07r+Vdls4iJMam2mgiaxgjZ
         yh6g==
X-Gm-Message-State: AJIora/LEXeO7ozVN0BKhfRtn2eGr3YZpa1a79J98QB2sKPdh+hwwc92
        tbm/mJO1C8F+ZtoaOMxduUjfBux49hh5Ql58bW8=
X-Google-Smtp-Source: AGRyM1u1NDpDm2e29UEdUXejR6vVizhBAylatZujpWg0u3c8WuR0wmlfKVExje5frjgBQbluusqg/V51aJiVuHaf+Tc=
X-Received: by 2002:a65:6c0a:0:b0:3fa:c20c:cbe7 with SMTP id
 y10-20020a656c0a000000b003fac20ccbe7mr799900pgu.611.1656107372099; Fri, 24
 Jun 2022 14:49:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:62cc:0:0:0:0 with HTTP; Fri, 24 Jun 2022 14:49:31
 -0700 (PDT)
Reply-To: c12345shara@gmail.com
From:   Mrs Sharalsi Canales <cwillk2019@gmail.com>
Date:   Fri, 24 Jun 2022 23:49:31 +0200
Message-ID: <CAKDv1qVezyRY0XP7-bceC4tqvBkOoDzdY0s5c_a9kPK34CCwfA@mail.gmail.com>
Subject: Urgent Attention Needed
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5007]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cwillk2019[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cwillk2019[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear,Peace be unto you my dear , My name is Mrs Sharalis  Canales,i
have something very important and urgent to to discus with you,if yes
get back to me for more details,thanks dear
waiting to hear from you
Mrs Sharalis Canales
