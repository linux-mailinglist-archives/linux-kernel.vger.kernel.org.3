Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AA44913DE
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 03:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244080AbiARCBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 21:01:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236398AbiARCBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 21:01:19 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED67C061574;
        Mon, 17 Jan 2022 18:01:19 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id f24so17861203ioc.0;
        Mon, 17 Jan 2022 18:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vb2rrR4h+YljoqTGD7A7yrMbD06xZ7EfxZFLjHYWfMI=;
        b=Sh5X6GRw+f6cBUewf8cxceZ3m25KBXjfv5QWzxd3Y0fce2+6SFlT4S3Zu8eOQhAGMv
         BRwVSIdNe8vNy5/+VT5TXTsFp3KLoV82TegHMVMHOFQF7RXYwseV+N3qXqn5wU9USqPu
         Y9lOoyBz/iL6UHAV3tEWH8fmlbshBCTonbMvrEm+ApOTSa/fmuYZzWXEkO41EKantNBS
         a5KW774m5NmVP73YWDjw1jFtS2cMWEES3dQ8j/b11pQKVMGsH6MsyXRHeV/anRPJdrCj
         SqQYAihfMv3NqWOmXZDOoZ9c+cGpNuMujnee+FANsJL2AgVKHdfz02dqTL1ZR2STzVsT
         cfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vb2rrR4h+YljoqTGD7A7yrMbD06xZ7EfxZFLjHYWfMI=;
        b=QHSnkhbmtzWtwFxGm7QefB1YkF20XnFdNb1PwzzJh6t6bxbZC+SHDMzh72rvAfh0U5
         Z7KGyMMIgW8Te0Kf4cCcAMOqqXxAjMsXUKe2+on9Gq7yfOEjMsMYnaJfkzNty/TqTQDi
         xFuHP+MV0sHI/3rP/5wh3uHvmXCXs5TavSvFs/T4hLm+W6Hf9D8NsFbcpjZGKG4MoYY0
         xpbDQ9uo5EcNs+XMh4et6LXbaLtPVjaT2G3P5yPlSZrcBk5OgaEVASVLP/G8TMJ2Iuju
         A51V5CXmKZPvPmghsubWj8rWLbuoGENgimIUtz6LHVVx4m2FV2005Ok9PfHoLj6QS4i5
         Zpxw==
X-Gm-Message-State: AOAM530sAbwkiT8KZ175N0t4Zt0AmvYzJ01PJ07yIh5Urwpcd5FBqlyy
        vPHcRhy7h0UpEIGlxfeDX734aE9OebVR3eynfnW11zuybHN6IQ==
X-Google-Smtp-Source: ABdhPJzJjq61eSjwA5HsR8qJglU7v7SVegre9SW/3377O0abd33DxOjkmNL+91vpfNoRDEiKrem7Fa99JUmdtwONqNE=
X-Received: by 2002:a05:6638:348d:: with SMTP id t13mr2990399jal.37.1642471278552;
 Mon, 17 Jan 2022 18:01:18 -0800 (PST)
MIME-Version: 1.0
References: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
In-Reply-To: <20220116201843.2301438-1-eugene.shalygin@gmail.com>
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
Date:   Tue, 18 Jan 2022 03:01:07 +0100
Message-ID: <CAB95QATXnzoRfOqt+Q3R9m+Mpm5ou=YQAGq+f5EOJMvGWVRy-A@mail.gmail.com>
Subject: Re: [ASUS EC Sensors V6 v6 0/3]
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Denis Pauk <pauk.denis@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G=C3=BCnter,

I received data for one more board (ROG STRIX X570-F GAMING [1]), thus
shall I update the patch set now, update only two patches (source and
doc), or let you finish with these changes and then send out a little
addition [2] later on?

Thank you,
Eugene

[1] https://github.com/zeule/asus-ec-sensors/issues/10
[2] https://github.com/zeule/asus-ec-sensors/commit/d45be0a21f47b26727b87d3=
d111304d0533beacf
