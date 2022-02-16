Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6954B8769
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiBPMN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 07:13:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbiBPMNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:13:25 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B3B2A228E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:13:13 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bg10so1844715ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 04:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jn+zGX1FBd9vuS3OAi6WVZ0soSNdyvhXWR8AhE72jvI=;
        b=cDwxlDNxUlDIJ9vH2rzXMofLaiR4eDlOVY2DTfpe+3/cvuGEOl72GXzY4g7JK2A93H
         Wktxo81+/osKy1wWWLCZFOEqheduKb/oSwjHtqtQtImUbEoCP9eDDUHwidHFUG4Jfnp1
         5MRogANZxCY1mvcTgsleVDbitLGgEtZpgCZVNFSE0+SSLoFQKGSNx4LP79k6sJ8iexdY
         p3vwwQo6cTMWt4nX8xubUZ+u7q6jEYe/26SST1IDESpxEXMW0kY+LDvxXewIXBjE8N+5
         phMQS+22eCrZlbq/1qNjW6M8sOlkmXPs6Rm4MKtSWDF/7xxpfLbawrPaHDY5Bwd6TQjJ
         EFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jn+zGX1FBd9vuS3OAi6WVZ0soSNdyvhXWR8AhE72jvI=;
        b=LI6c8ummEeL83RrE37TcfW3s1aBQx8BoqbPhG6eN51pFHnzBEMpgkzAIcPWdN794DQ
         l98hnABzW+FNCqi1YsWzkB3lr49I8CZWAkK/HzZRim9kGp1hINLcJzVy3SzoOPoxwFkb
         eh2XeWDfBRdBi8YhTnLNXDNLGN3O54C2ARz2IEivXV+K6TU1z38jFQB4vUi4WR21C0zG
         eMd7j/+4jfitLWR9FQG5l3+GwMCnKHIkMByUpNB5zlnq9PyeSZ20F26F9k4qBGnzCRLb
         YZTjlnl2O59BJQSRecicGD/4FNemJp6nyT6bp3CcHxMbT+81NyUy/l840027BBPe3Hih
         lErA==
X-Gm-Message-State: AOAM533wAeVm4ReiciKLa4dXjCBMkT8IpAHA6Q2e6RRWEyhb2m9iYLEh
        p8CWnnXXEE036d1MmVWB4NASXYUI6Ej9TovyCvU=
X-Google-Smtp-Source: ABdhPJxoC5M0Rs/v2YU1snALWN0eUF4+bPCK/d9abePkPEdarkXB0MAnNsh3OcL5+o+BDGTnQ1g0U1otBRrNKC1uL8M=
X-Received: by 2002:a17:906:e92:b0:6ce:3f3a:5e64 with SMTP id
 p18-20020a1709060e9200b006ce3f3a5e64mr2112607ejf.194.1645013591907; Wed, 16
 Feb 2022 04:13:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:907:6d12:0:0:0:0 with HTTP; Wed, 16 Feb 2022 04:13:11
 -0800 (PST)
Reply-To: michellegoodman45@gmail.com
From:   Michelle Goodman <sarahtage24@gmail.com>
Date:   Wed, 16 Feb 2022 12:13:11 +0000
Message-ID: <CAK7Gz5wng-Yx3OTnaV0z+vYnsB_F9_jATXRu9khkArPCxEHFjw@mail.gmail.com>
Subject: Halllo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4895]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michellegoodman45[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sarahtage24[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [sarahtage24[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
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

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten
Danke.
Mchelle
