Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753AA5707CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiGKP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbiGKP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:58:59 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5112ADD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:58:59 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-10c0d96953fso7282648fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=04kPzm+dTSSl4SG8BXwCn0g0fqoY39UfUl62Mk1/W48=;
        b=G5uAovkfQRQvMGRz7yVMf49sDpTuWCydJ3Ay7OJ2EJxXrPdjYB/45Wm0Z4z5LObaFd
         6JhshSoi5wn9x7w7/jK+ZPX1WjQawtiRiz46291jqgxMAkaHZlDSZ0FgLDYNL8POi0t1
         bmJSgel52kST5DtiwNCA2swn+6f6AWAl1wviA5h+b1/n97aAaeLG2TeyNDVliKxSqf4p
         S8qiQjLbsaYAIGV1u+6kEbEsLGMMmQgLAB01lIrDp5N3ic25vO6N7xq/ibv1Psj13KL2
         ajnItWnSu3jXBCvrji833X8ycCiPx6nhNELpO5n3lQIBY9ChEVlmgh0JenkTzbaCvHEv
         fjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=04kPzm+dTSSl4SG8BXwCn0g0fqoY39UfUl62Mk1/W48=;
        b=qJs6bXsUU8JHhJdoM0xc+gZ2NZcMaGrDv+e7fqvAhpM8CZhbm87x4MEy4cU9qY1EYO
         ORamvxuW8N1KdTxYXspF9GHErmoOkdMd1Z7GanpTlekWPKRPTaWt4rGFXqo78lv5/+g7
         v7vDxp6WQUiJWlwW2xMTFchc7Yqafu+ejnjGnLeSETjOMD911crz5MnHMNkufmhpTCPe
         o5eYTu9g1tMdi6855kDF6odw2ayNRZbxZshGHkZyVdGUVyeJZeCfdxl54qc+5NVPtzw2
         6aweFboK6Uc9fcEg7Kqt8lCAxz3JdS8jHS6zilyuCTuR6sfOAQDNazuho/553cszZ572
         b3/w==
X-Gm-Message-State: AJIora8vdkIfiH5IqGpkBLyX4ROX7FqSHDx0sZFGrJRV/vXXRnND0vdJ
        +NzGL0GN/o6Mc+aOE4aL0dvs/D9HSuEi0oTToMo=
X-Google-Smtp-Source: AGRyM1thrg3tyRGsNZc60/8e8FvXawnNclPrLClfyJ6ypVuRwlET5LvtrsLg+jlgr8Du5YfaLwMd55x602LTx+F7m4M=
X-Received: by 2002:a05:6870:460d:b0:10c:27e2:1de with SMTP id
 z13-20020a056870460d00b0010c27e201demr8070683oao.7.1657555137940; Mon, 11 Jul
 2022 08:58:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:4907:b0:af:b0dd:b14 with HTTP; Mon, 11 Jul 2022
 08:58:57 -0700 (PDT)
Reply-To: mrs.mutanda.wilson14@gmail.com
In-Reply-To: <CAFiiNEVNfxgEPxcJOeb+CjL9m5v4G1hid2SK7U+yHH6JzOi6MQ@mail.gmail.com>
References: <CAFiiNEVDLXbLRh8N9FV_f7Gai44zLXy4uESBQ3kP22Z3EgxYaA@mail.gmail.com>
 <CAFiiNEWU9BY4YM7cdu4j=KVV1e9xtkQXy_Hq35yjPf66m=ZrXQ@mail.gmail.com>
 <CAFiiNEUx9861rGaGkLXWASUSAj+PY8Y8xRZwU9ZKFxc6JKuUOQ@mail.gmail.com>
 <CAFiiNEWQM2hr=Od9pv7vRn4izLOv-mbJHTTgAUbwN_SO85R00A@mail.gmail.com>
 <CAFiiNEXm-AUWFwc+cQoQKZrVjN4AydAG=Bhdevg8TBQunRSK0A@mail.gmail.com>
 <CAFiiNEVTw_bJ+eWZL5vQweYM5SB3pDzEnCoYpGvMH0DgWzU+vg@mail.gmail.com>
 <CAFiiNEXkb=Pbv8fqvDPV5oXeu2iySA0hAGqDzC=Ubcs+=MiYqw@mail.gmail.com>
 <CAFiiNEVhh_Gz12h2nR8AEqSUPanr=-zyH6hmw1Jzoh-1Wa1awQ@mail.gmail.com>
 <CAFiiNEW1S23MB+Pa+A=id9fpeK5pwxO9=qFu_+MqwTzF+7+ZRQ@mail.gmail.com>
 <CAFiiNEWsYNTw0FW4Dq-OTreXf-qLaZaUVk5p8wbBx=V+ken7-w@mail.gmail.com>
 <CAFiiNEXddJ7tzfnpgNPrfnYgjd-JFZ3DwBSgE-xbuix+qHaWWQ@mail.gmail.com> <CAFiiNEVNfxgEPxcJOeb+CjL9m5v4G1hid2SK7U+yHH6JzOi6MQ@mail.gmail.com>
From:   "Mrs. Mutanda Wilson" <prosperetina12@gmail.com>
Date:   Mon, 11 Jul 2022 08:58:57 -0700
Message-ID: <CAFiiNEWoGcRTj_qdAUe8OFgxK-kRxXP8AmFygs59FecOr3Rzyw@mail.gmail.com>
Subject: =?UTF-8?B?Qm9ubmUgam91cm7DqWUs?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:36 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [prosperetina12[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [prosperetina12[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.mutanda.wilson14[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bom dia,

Estou em estado terminal e prestes a morrer.
Sua resposta positiva ser=C3=A1 apreciada.
(mrs.mutanda.wilson14@gmail.com)

Sua irm=C3=A3,
Sra Mutanda Wilson,
