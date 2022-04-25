Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDD650E034
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241909AbiDYM33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiDYM3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:29:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D303689A5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:23:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id k27so2986432edk.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 05:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4NatFtrmA7Gzh76Aj3XWil5U9hfb9RBYqAXRtIqLhmI=;
        b=n4V/hVzSxjz2gmRf52QZupgnfGttrS0NTVUlwheFVKmfElItPuTviGQEjDIhELSlIu
         nsQ/ktFMogzgDoNVDgn1AQMzQZ8ttX9n5raSevSOEBoIsm3X0WPpkZ2nFfV10BuGx69H
         QvwF1T6DyNEix7iawvSewDwzWcpPrc2ux79fPlBFX05jWYEZ8q/TxA1TPXpNUUBYuPve
         OAyZh5W9aRfKELtCv3f0Db6pFZZXQyPB1vob+7l974gfn1OvdQ1X3gORIrgh5ean0NVX
         1eP5aO7R4IczdyOkJGfziuK5cT33nT/Y0Sq7rwXbjlCmpt3u1vjys/9Vzwsgprg0gXnE
         IOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4NatFtrmA7Gzh76Aj3XWil5U9hfb9RBYqAXRtIqLhmI=;
        b=mE5IJOhAkaunbBBq3rN4z9UOLlY+CnQCk2Xd1uygDkO3gFZGgZfnmS/RQpx7PwoOAJ
         eYoHRkOgs4HPkNfRcvRjpFLkmIrGggKrBWWIw7gpIKBUJvjJuNUchu4HpRs1HGhM2RbP
         MUXSOSFos+Nux5tOToBedYMP9gjS/eWTRu3hOVT09knKFFi2toPJJlyAmpbac12aFJNf
         47kXoBNKvAhlsOr0GCDDD+ZklEk73tqajZsLX4fhc44D6qDV3lwEwhOr6DPtv3dH7I+6
         XTin0+cY67ac2lg+Sgslr4l0XPjAiwD33O5vhsNZs9i25jWe/G3l5PUv8l6BlfF9LQLI
         Tw9w==
X-Gm-Message-State: AOAM533Id9eF7hqPvGQfbrF5BhSt3rUpAgHrM4CchFar1TsEqCVuu6xU
        7D0va8Qs/J48y8rNf77ZqGuNN/gj8Levt28cP24=
X-Google-Smtp-Source: ABdhPJxtig7pIwM/oO6JB6Ya9LF/a/Jdk+4+ZawgEBJCmQKA6j/a6rZnlGosO+4CR/5q05bZ/Omfbe0V+sYfybdD3mw=
X-Received: by 2002:a05:6402:4008:b0:425:e769:c001 with SMTP id
 d8-20020a056402400800b00425e769c001mr4913520eda.34.1650889412611; Mon, 25 Apr
 2022 05:23:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:7205:0:0:0:0:0 with HTTP; Mon, 25 Apr 2022 05:23:32
 -0700 (PDT)
Reply-To: ahmdkalifaz@gmail.com
From:   Ahmed kalifa <walkerderson@gmail.com>
Date:   Mon, 25 Apr 2022 05:23:32 -0700
Message-ID: <CA+g+r8of-f4aTB3jQJx1b-Nj+47CriEvu6eXJHMmzBvzCeEG0Q@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5034]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [walkerderson[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Attention Please,

My name is Mr.Ahmed Kalifa, Branch Manager Dubai Islamic Bank United
Arab Emirate
Are you the real owner of this email address? I have important information
to the owner of this email address.
Due to the sensitivity of the information, I want to be sure I am
communicating with the rightful owner of this email
address to avoid making a mistake.
write to me so that i can give you the important information for your own good.
Congratulations if you are the real owner of this email address.
I am waiting for your speedy response
Thank you for your understanding
warm regards from
Mr.Ahmed kalifa
