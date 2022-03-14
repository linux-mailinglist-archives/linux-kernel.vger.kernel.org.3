Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 338864D80A1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238913AbiCNL2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiCNL1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:27:54 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8C13B02A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:26:45 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id v14so8474594qta.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=qzk10DvAB5A/QOhSA/kyBz6hfYECeRPeiHyb0l8866U=;
        b=b9YaILZnVp5xmDz/CUgSW/HQSfEyJhILm4mTULr5G/t5w+gdBg5SUi52ZaaVABwmOO
         a9UTROuWEpiKAS5b65mRUzdjFZIhAbSi48TUuo0eLickx5z7TU27lcVdI7CpkZUq+Mym
         wB0V5QhRKim6xmZOvnVcNi3P08QQf2AJsFoMWOzVHLSnLBFEbkngG9EyyzpDA9dxChkZ
         97HZG/KzUAQAOI/oT+olEuhBse919xWeKpfDeVdchf5tMCRHDksE+eedSoj7JJvUa9q5
         VxFAd/yxJnDwzk8TCQDz59j/54dV9cs1fdb5Obbk5YExZrbmcm/W/dBiiBxIa4ry67cf
         /7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=qzk10DvAB5A/QOhSA/kyBz6hfYECeRPeiHyb0l8866U=;
        b=zE5QZE5JI7yGI4cGmomAL1i4CPY5cIBV8ME4zauuUkEa+78JaPWS34uuCFXgSF404f
         X1wHWqrAGHyCHeHUjH3zbxZqfqSmtlqcd/lwBNbqAqOwS3wX/McD3TCn5kOVFWMVe+Bp
         S2Q+d9/9Rydr/2GgNO+u4HGWD9tJYT+owGUNNiA2emugHlEFlZuxzsKVF8sv1M5yJUZa
         aHCUdCxIgPUpU4ASp2tqj7Qfd+LakI3EvGINyEoeX329MJ1fdEu1pPtb4yix4fzQo9Bt
         OI6futq3dS3VROQh458Ca4heNYCI/jL36wmqbfV5Djvg+JkwxQgQwwZ6acWy613Fu09h
         ENsQ==
X-Gm-Message-State: AOAM5334kkUNPXZyxOTsBMKzvZ8NabHBp07oYfnKDhYi7cAymhX8TP82
        YM7qLek9IlqVNkTY7AFhrU3ib5vbUxoiGiZ637Q=
X-Google-Smtp-Source: ABdhPJxpHx3FMNLwIo8rwaL5f91jfexLZjKl4MtGS4wAhRHpDG1O1uHJZzSGQVrLljZ6Zuz4yIjgAZLFttHs3c+0H34=
X-Received: by 2002:a05:622a:c7:b0:2de:6f63:27a9 with SMTP id
 p7-20020a05622a00c700b002de6f6327a9mr18270559qtw.608.1647257204553; Mon, 14
 Mar 2022 04:26:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad4:596f:0:0:0:0:0 with HTTP; Mon, 14 Mar 2022 04:26:44
 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <michellegoodman358@gmail.com>
Date:   Mon, 14 Mar 2022 11:26:44 +0000
Message-ID: <CAAnwc9uRViKft2yJw94XKyru0bo-evbsn6w5EMY1Eqi3xAjPeQ@mail.gmail.com>
Subject: Danke
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [michellegoodman358[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michellegoodman358[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, bitte antworten Sie mir, wenn Sie meine E-Mail gelesen haben
Danke
Michelle
