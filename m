Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D88547ADA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237766AbiFLPqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbiFLPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:46:41 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FEA2ED58
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:46:40 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-f2a4c51c45so5533282fac.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=gFGhJTRj1uRix8k4NcRcxZsEjBSZRJrH9xOtC+4dMro=;
        b=LHR3XuTZezq5J3LpU1Xwzs4oexCkV1qGr3yjaYn1IyAndZZafxaNz4yTLcy8fw+2P4
         b8HTUmDuSCa04RDdh+VP522e7JZZcGJvsdWNdxnVyS86SttQTC6XR+0DcmW44xoYCViz
         lnu8fHNBYQNfsiHjC3FFAH8qK+Wt+c68u6v9PUQeiy5FZXfSYTvIq0dpBI+9piXIWz96
         K4ypQR8T2Z4XOQerVEiZwRQACv0lRD6qD84+owBjOsmDcV+C5CUejQww8EZS5bHVKOHt
         FAJ338cTmgpwV3AY2DC0ZLWTPlz38E4XmBOs/OMUUVII4ZizBOC/zJGAFxqzOJbr8LtP
         Uk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=gFGhJTRj1uRix8k4NcRcxZsEjBSZRJrH9xOtC+4dMro=;
        b=5GdBlfgLyLFIMDQwz++HpRmn0ZhVJ8eA30W1P2/RdeGUp70XChQQjzoafKXHPSU9Pe
         KVOUPNXl9zo0QhN0tfWw9WYrD9GEEor8098hue01vsQYq1HYN1hjLmHfw817pDhW5pYM
         0wm/KSVq8tJN/RVMxtK6UshR0/sQFmKbXPOv9JUz65fiAdFdYg7syhxkf/jwDM6aEvYm
         oME0DL1+86W9ciuXubqedsN5iCMfe8GyKnMYQTm4z+EygcihK9KRkdFZmSnNvk0o0FK5
         nd/3xGxRHq+lt68OplLuyllwAiQbQNo0cDXESRRSa4gXndttA3orkVVqjsR1EHgwkd8r
         AvxA==
X-Gm-Message-State: AOAM531ayqcUpL5xxQdpmbMN/BmEKtabh92Cg+RJBvjdjs6n5qzf+0hb
        J44Mn0Njn8WoMw+NjKc297P3TkXMHptVV7DYG2g=
X-Google-Smtp-Source: ABdhPJw0rkgm6LiSCFyhaHN7YyYA81hX5vSiVtOAIJt/AHuLMAm6BQNBv6sPpfkHyWTiA/+ERivry4VsuN/wnSftrpI=
X-Received: by 2002:a05:6870:e245:b0:de:9321:9ea3 with SMTP id
 d5-20020a056870e24500b000de93219ea3mr5120072oac.79.1655048799124; Sun, 12 Jun
 2022 08:46:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:99a4:b0:a2:f157:f61d with HTTP; Sun, 12 Jun 2022
 08:46:38 -0700 (PDT)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <tw44015@gmail.com>
Date:   Sun, 12 Jun 2022 07:46:38 -0800
Message-ID: <CABtpmn2f63z6N8O_vzzD+i-Hu7e9ubcB-FcX-8zH=oPtFf3Azg@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:29 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.9362]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tw44015[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tw44015[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

My name is Dr Lily William from the United States.I am a French and
American nationality
(dual) living in the U.S and sometimes in France for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lily
