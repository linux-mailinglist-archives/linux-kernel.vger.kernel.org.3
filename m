Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E46E4FBDA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiDKNsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346671AbiDKNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:48:00 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221EF12090
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:45:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i20so9987589wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kj4z9yewXR7aW21g+eOj3iFx3oflVnfPYMtZxVY8vsA=;
        b=QQDhN+VYsYdEuP88MlFFENowcE7br9wAhppIZVv3XVuldHyjM5mrXMx7Hr640tBmr1
         ibYQjxzRtVKCnrF7CK3X18QR/4iPDnqmqTQHExkQIVjoqg1/ftJkXp0BYVxVPSuH2zVr
         sSTtpxb8KcjjD1dvLBy6sYBbyYJjIAGD7P7u0RVUiIHqvr80jeThsA4QLn0dmtlGxECE
         RmKMgnRKfGw4DQUtvKANVMA39R/5YbvFQ7DXJqhycCC4hqJOxIsD5c9KuL5dnwhq/CJO
         aJWsHXco2Qwd8MhPGrzD/LLih1UfRbKADq1OCKi3ttUW7OatVEYxJx/Xm2UBx4vOqsOZ
         BP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kj4z9yewXR7aW21g+eOj3iFx3oflVnfPYMtZxVY8vsA=;
        b=dnHcZSq26rDr84kF3njp71kw2uMPY1DqR/EqIHwFncPqfW4dmExDVytLsOzB5NKyP5
         H7J+sabWpkhUoEdOi50oKRuA3EKwuGDC+FjPxCPOPp27m4Y2+r9G361d+uW6Ek8KFcbD
         hdhqtaFuM0XOeCv7PZ/E1IEeLFnqSfEIs4Y0DWoSTYnxAaK7r7Me/muGUOl/0I1Ygqkx
         2Ab8RvVw3yu6vuZkE455xB/pVEFUeWhEm/jJAIGVgVBckNkaGr6r5kY9fb0Fut+lf+q7
         NzvcaX+LtvD5xVHYBQCh1pNsfys4Gxz/W+iNQ1iS+gCWYKeEgvU12w6CLv7XRC2Q+GNx
         QBPg==
X-Gm-Message-State: AOAM532m9XvpS/4M3GIF9/NqI68jGS3yqOQBAPDK5G3Z7thFP1eMAEl3
        muSye3Ng5OSt6kbJQ6uz8Ys/wrGjdtju8SbLkok=
X-Google-Smtp-Source: ABdhPJw2uf2E+b9pVXCi2g7CXTatlQ20DESnalz0/trfmF76le3zY/Qdr2V5f0mJYIaufNfdTvqApJuqTGgbsZ6cacw=
X-Received: by 2002:a5d:59a2:0:b0:204:19bc:42ff with SMTP id
 p2-20020a5d59a2000000b0020419bc42ffmr24194803wrr.687.1649684743498; Mon, 11
 Apr 2022 06:45:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1f94:0:0:0:0 with HTTP; Mon, 11 Apr 2022 06:45:43
 -0700 (PDT)
Reply-To: rgicompanyltd1@gmail.com
From:   RGI COMPANY LTD <antonioman388@gmail.com>
Date:   Mon, 11 Apr 2022 21:45:43 +0800
Message-ID: <CALR66yr+B4_vO4dcjih4iW_zGkckshr9Gxk9bRYUr8KpNKAd2A@mail.gmail.com>
Subject: ATTENTION REPLY URGENCY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,SUBJ_ATTENTION,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42b listed in]
        [list.dnswl.org]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [antonioman388[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rgicompanyltd1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [antonioman388[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.5 SUBJ_ATTENTION ATTENTION in Subject
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RGI Company Ltd
Address, Netherlands
Greetings from Netherlands

RGI Genealogical Investigators particularize in probate research to reveal
missing capital, inherited estate around the globe. We can also help you
find wills, retrieve/secure copies of certificates.

Recently a woman from the Rothschild family, one of the famous families
contacted our firm that we should contact a business minded person who is
capable of establishing her capital in a lucrative sector.

Our professional co-operation is 2% of the capital and we will be settled
after you receive the capital. The capital transfer process should take
just a matter of days as we have the mechanism and expertise to get this
done quickly.

Please if you find this letter offensive ignore it and accept our apologies

Warmest Regards,

Dr.J.T Wood, CEO
RGI Genealogical.
