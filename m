Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA748461112
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbhK2Jax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243223AbhK2J2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:28:52 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA38C061396
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:12:19 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id j3so35181134wrp.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 01:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blogsoutreach-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:reply-to:to:subject:content-transfer-encoding
         :date:message-id;
        bh=Q7qNBVtLEfLs5DBpQyguH+ZhZRYa6SP1l2xOa2ePsiw=;
        b=Bhxq5WwYAUlrGGX+DjOnJXuKU+9+11DG9y0bSYAUdi9ZxctLDZ+ci9hqagQzqd6ZEK
         9V1pK9Yt8xGK01aoE4bI1GbrS4xQJAhW8JLu/gNP+QuJ/AYkoO8okRVGhBrG1S1P3c20
         hH3dNcp/st8wPStdxGmYPo7/6ciEkaWg8tK8iZQb06sD9Jv/rOvk7WyJhN/LcshkTaHJ
         r0XPTwpCHo9kDFGpudbcWshIqX0NuEFE9peM/4GusafK3pds3Gaui5Yvly8QjDrnLUtM
         Stqx0fbGgX/V9JuiweczCpmWCpzTWxv9PGNw7QTRn1KUcYVPzWwgZGMis/aQYmxsL5n/
         k2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:reply-to:to:subject
         :content-transfer-encoding:date:message-id;
        bh=Q7qNBVtLEfLs5DBpQyguH+ZhZRYa6SP1l2xOa2ePsiw=;
        b=6f11yN+0URXQlWa7RTHNBzkHchRD84r+KC1ll5gHJ1B6FC48WBbIVASnHhg04XuARp
         38TVDoue8uXU41pykLjE+uXJYAkVTzn8Bsqli6orvXeeP1Sf6KdQpMFzJ6m1OZlLBcdV
         NDWFa6te6A5AYNqJy5QQPsJxgEk/ix+Y1gMBJYSoncN+Kzj4VKzxb3eVLac6eXAopqX2
         D9SNPawf80tSxUjRcZigdq0ZsA1+2dXdEnqf6+4/PzcCcjOYRYjv4Hp5hxqdQp/9HX/v
         tAnYpfRFsEkQaJLA0FoPfz0Tn7hPAMV+9RvmZkKV8sBdx+euQGML34MpqWpbYMfBNNTL
         UuXQ==
X-Gm-Message-State: AOAM530tpyiCzacanv80L94qHIt8alKJNDQBClATui/viEl9Fctgukez
        IkTOriE0vVTeUuD10IG5PDmFHDT4wH4WHg==
X-Google-Smtp-Source: ABdhPJzFqE3xeFowsZl87AROa0WdzrCnLJckKSu9+K3W2R49rykwPl5Ka0OJPbTqLBtOqrUamBqhqA==
X-Received: by 2002:adf:ee0c:: with SMTP id y12mr32062048wrn.82.1638177138184;
        Mon, 29 Nov 2021 01:12:18 -0800 (PST)
Received: from 137.59.228.238 ([137.59.228.238])
        by smtp.gmail.com with ESMTPSA id d9sm13050515wre.52.2021.11.29.01.12.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 29 Nov 2021 01:12:17 -0800 (PST)
MIME-Version: 1.0
From:   "Michael" <michael@blogsoutreach.com>
Reply-To: michael@blogsoutreach.com
To:     linux-kernel@vger.kernel.org
Subject: Sponsored post
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Mailer: Smart_Send_3_1_6
Date:   Mon, 29 Nov 2021 14:12:01 -0800
Message-ID: <1408241105816104739653@DELL-PC>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hope this email finds you well.

I am sending this email to ask if you are interested in sponsored posts.

We are searching for relevant sites and blogs for our clients.

You will get 100% top notch content with 1 do follow link relevant to your =
site niche.

Please let me know how much do you charge per post=3F

We will pay you through Paypal or Payoneer gateway as soon our article is p=
ublished.

Looking forward to building long-term business opportunities with you.

Best Regards,

michael
