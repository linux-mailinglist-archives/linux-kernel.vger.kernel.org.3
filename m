Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCED527FC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiEPIeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiEPIeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:34:10 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A0DE0A8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:34:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q130so17206227ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=o0qudJChmRvhx2giXx5fvIT+yx8UdlmNUYCGDDspMcA=;
        b=fprpjpnXG8Yqp6yXgOrJHJYrNuxLRgeCdiVDvWSi//d3TBUh30YKx0sa86/8CMTKTJ
         wx8ip8UosO1wc877qsOoh+w7UmM90Qpo/OQruNF9SQICH8/z3uS3561UzxHwszNXHvDt
         ZgCqw2U2rTTDsk+Z4tsFplDrSRZ8SDUAxDyQO5rhWbXsRpDPW9V3rIMKdRV6ZYS7fetZ
         YYm6DOuWQjH1Xky8i7aZoLBa1wFPgM8eiAUYa5eINnFXwAWo6MMvUsyFqrb15Jc+oGiB
         lhwE5QYsXVmtGmIBEHlkI2crpc6qu73FfevV7Xy1nhIIwrPX56uSNnAP46BcbEYLZ5L5
         Kp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=o0qudJChmRvhx2giXx5fvIT+yx8UdlmNUYCGDDspMcA=;
        b=QuRUQ2SfpkUCInIYOlcev7FtjN9Te/b96kp0xYaUK6lJBjQGQtVnHvNinwLoHj+LOD
         EUrTmf5vJXdDz9XowSSRDFr+pl6Qi1jP4VBqlFgqnXh7VD4SXYrcdyG36woFxmAFqZcJ
         eZBi0s8hlwTy1Tkm4ZrpJ7hnq0+1Mju4yzB45ziAUbzKQp+ycR1boVH8cjFPQlNQl9P4
         hde8qAF1W8SmUWWdKsExeUIMADpLHCQMKVpIfuGQBgj+vEg67m8rLsfqbKrKQhtAou1H
         KkhOB2VXTMlLKwBmc6yT7Scztqnrqd39VxxUOrqpBixnnIgHqJjoBRiOiL/MT17Pg4Te
         p1UQ==
X-Gm-Message-State: AOAM531efCReHATWY20DzsRnOsaczZ/akTnJTqRrNIv9HNynCMmyBYsJ
        SFhiMzSg6Q2KxAg08j6pItATFvFP2i5/6a4plxA=
X-Google-Smtp-Source: ABdhPJwQPSvj+Bkj0gDY07j0+6aE6KStNIIvOK5Ncph88Tz/xX46V6zaC5CsCmE2LpwNLP/sa4BcJ0WqsIdW/O1HIiI=
X-Received: by 2002:a2e:86d5:0:b0:251:fa30:2d6f with SMTP id
 n21-20020a2e86d5000000b00251fa302d6fmr10189542ljj.322.1652690047658; Mon, 16
 May 2022 01:34:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6500:b8e:b0:13c:c14c:e17f with HTTP; Mon, 16 May 2022
 01:34:06 -0700 (PDT)
Reply-To: jean.micheal33@yahoo.com
From:   Jean Michael <alicefrancis811@gmail.com>
Date:   Mon, 16 May 2022 01:34:06 -0700
Message-ID: <CABBvBLDLqmPe48pvh8v_v2TjX0CRLXwz_vZgQOcw75KXi41Hqw@mail.gmail.com>
Subject: Hi dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:22b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [alicefrancis811[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jean.micheal33[at]yahoo.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alicefrancis811[at]gmail.com]
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
Please did you receive my email if yes get back to me for  more
    details about myself
    Thanks
    Jean
