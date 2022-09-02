Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC45AADE4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbiIBLvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 07:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiIBLve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 07:51:34 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DCADCCB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 04:51:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id f9so1185252qvw.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=K9aCivmd3pOhXO+7wSe24RMSLcWBP61HE/hhO1yg1yw=;
        b=bXoImPOcuWuXjV2xpTZoF36s6qrArrxsqvHkFEhtk9ix2itPeTjgiOPtY2bLsWkmrl
         6Ufo05is8hgxJ4o1pUDbQOh5MOdZs16G4VHlyA2EE3EgcGCY62/VTdaTipBDaOGkzRL+
         5/Cos5QTsMzQ1BFZxgKXXTRR6KqMQVphfpoxb6MSsVj8fjH7Hu9LsJA1ThamJYSk8zn+
         UPnqj5KHr7XNQuoBOuPbUNMCDbua5+UGygOq45BhVtOZhT4JAdy4FCxCTpilgM+M1BYX
         JWNxu3Bn/HoTVeUz0T7ovDA7+uphgRSTnUqlnTVmYU0ZHrRf2vqLvZcUV0dI0m5Qyccd
         0BcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K9aCivmd3pOhXO+7wSe24RMSLcWBP61HE/hhO1yg1yw=;
        b=HCdRp7diZyBUKwuZTHARUBHh/bQhTBaKkSsYGfg++Z8sczfJNGwJPvyN+QEd2n0eAT
         xUs7eO4PSWRsLaZqfkxmYhwxoZ4keS4ArKokV64bMMpX4i7v0sXfzXnMVFsQTN/UdApG
         WGzERZaqX9umUtfiJ6Af98klFlWKnrGoaVIanVrn9Qrhaa6JgOBM0xxT+EiSMRXR2/pl
         rGz9BOQYIQMl40vvvtAVHpXoLDEly58v21V2BNKNTVRSKnp1Fx7tHkErV+9OThgDkWii
         vQ7Zp+yr2HRgvV6vzzaBxflIuPKWolqP7gJ5sPaW8dWXTSegvDGVn/BJA24stSxnR0yT
         WwNw==
X-Gm-Message-State: ACgBeo0LiBkVJ0yXr2dJNW9OnzOveSQFLyr3mVUJRoYCDB3euKjrW3OL
        oNrk4bZ+hLGbF6oFjgq3wCnmTeG7dCf2r49RbHA=
X-Google-Smtp-Source: AA6agR5wUzmFtRyDoFJJQcjATTZILhwgyHP/SqhcTuHn2kkIrWiMADvPJ0CS6kInuf7cSS3wB6GCKj71y1aUyV7dbck=
X-Received: by 2002:a05:6214:240f:b0:497:5626:d378 with SMTP id
 fv15-20020a056214240f00b004975626d378mr28679789qvb.46.1662119492930; Fri, 02
 Sep 2022 04:51:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:519d:0:0:0:0 with HTTP; Fri, 2 Sep 2022 04:51:32
 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidkekeli1001@gmail.com>
Date:   Fri, 2 Sep 2022 11:51:32 +0000
Message-ID: <CA+f86QkD5fZt0X_JtdS=KBpx+m+goAL+Z9fG5kOyQpjYnGjNFg@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f30 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidkekeli1001[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidkekeli1001[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

My Greeting, Did you receive the letter i sent to you. Please answer me.
Best Regard,Mr.Abraham,
