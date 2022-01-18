Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B039C492BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 17:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346879AbiARQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 11:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiARQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 11:57:22 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C675DC061574;
        Tue, 18 Jan 2022 08:57:22 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d3so18116547ilr.10;
        Tue, 18 Jan 2022 08:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94Bzrb5VK4eR7C0A0XqtZiqgCYuW0l9KUJVq7YhgTCo=;
        b=ibNJ8tu0H4QVzpnRxNsPyKOXLxfIiPhlLfvUhzIGN05qrWcX/8oFz1n1n2uEozg7y2
         HAADlIr13hJ0l/L1NOZxVxOBnO5XVTY75NegBJNOZpYUlwUkXm1sCqpYpbiZZIeRbv01
         oWZHc6AMyhNKLPcNqTGB33iEEtryl9Dt6JyzlTG0SKumt1kYMVavS6cDtAV35kfM9/af
         c4OoZ+RK908v28A1gW9Yh5ke0aXNXngtlSlCL7Qouipg7ymJV+QZ92dk+mOJ3OQoZHBu
         ztFp48cCnzRzQX2N0kjZAhUkwostvZRrsXd4UfkadyYIAgMtJwt0i89ERu+4ELW4Wbxs
         psRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94Bzrb5VK4eR7C0A0XqtZiqgCYuW0l9KUJVq7YhgTCo=;
        b=hcdFQeIzMcRJAWDBiA7uWIwjNsf3CjiqK1+wgMztCF/InKTYrjbFIbR0S2VKEHkvro
         0yhwQwTsiRANd1FEik2H4s117vdBmYmopvadFc1TwU5ReEz5B+QGND+SY9/z9vDQdSyw
         T1d6eQmqLpy+cEUX/ydFMaVtbpZhLT8SkOKyZNwzr0aRnpEC4g4aPzcZFzhY3JD5y//J
         J37tmM9VsD/js44L0dBVWPnvZqv/+WRSk7CRDnfU2zDO92UP6jyOJpE2qBc5AjLsDeyH
         plCt5mN5Ytvvv7CDZ/xIHUO6oWNloLws2+TKS0+8gs3PwM4e6sDw9xt6/Z9PCzP2Q37u
         3rHg==
X-Gm-Message-State: AOAM530AyJZJuXu5IogyvGKogrRT5ov/ytdsU4+UajFypdcD6J3FK0Mw
        UIDEG32ZPG01RdhIaefNn6s6MoNaXusk+ZGTYVU=
X-Google-Smtp-Source: ABdhPJzE3DTa9KXsRQZ2N2jrg1Ox82T1lMvweyj2rx9B74u2B1o3FvQJ6ftFy8/wywlzb24AopB8ApSnKiqWlExPt98=
X-Received: by 2002:a05:6e02:1183:: with SMTP id y3mr13548693ili.289.1642525042209;
 Tue, 18 Jan 2022 08:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
 <CAB95QATXnzoRfOqt+Q3R9m+Mpm5ou=YQAGq+f5EOJMvGWVRy-A@mail.gmail.com> <f80a3b13-ebd7-3e20-df36-4d037e7a9f1b@roeck-us.net>
In-Reply-To: <f80a3b13-ebd7-3e20-df36-4d037e7a9f1b@roeck-us.net>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 18 Jan 2022 17:57:11 +0100
Message-ID: <CAB95QATp7VQ0Ettbku9WSJDr6Fw5TczyKdUkN-QCrwC8ZUp6eg@mail.gmail.com>
Subject: Re: [ASUS EC Sensors V6 v6 0/3]
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For whatever reason the last patch is unsigned and does not include
> a description, so you will have to resend anyway.

Sorry, I had not checked that last commit. Resended as v7 with the new
board added and the commit message fixed.

Eugene
