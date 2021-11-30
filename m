Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F34C4641F9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345118AbhK3XLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345064AbhK3XLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:11:16 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE5C06174A;
        Tue, 30 Nov 2021 15:07:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so93501292edu.4;
        Tue, 30 Nov 2021 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=G7gSdmRljghr4kCI1mYUeOY0elmNf43x8RYUqn5gpmM=;
        b=fAUYYWJFDVtjaukiWR/RZdSrzB4XXRiHa+IHekwslU4pbxEjVBf9tlb019gsJq8H94
         WAgsRsUpptxwFPp7I7Xl5LRpJcJnvuClp8vGZqqUbIZqJtsbkrs7ZhdNQL5D2KqOsQiJ
         1Xd7bZsTrtq+DSpc+/BN6unYnZK1V/gtCnpHep2f30iGvCbzayaoIJ4bOD7/3/4RG1x/
         0QtxcmdRvO24cgcYY5os1odarN7E8GAaLOYX5N5iWFOdvWEny7tVlwRseXOHgwlAkGjH
         w3oOXPLr0QelSffYrdIGlRbphj2V+MaQzsl9wHSyWsQSqiGtpLq879m9k36D6Y4OTtc3
         mnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=G7gSdmRljghr4kCI1mYUeOY0elmNf43x8RYUqn5gpmM=;
        b=Ux2lc05eESm1zQj6sqM+bWojTZynMMQD0dS4jnBCe5bxwIg1Qb3puUpSG6dfYRRQSQ
         bIwEWfL7kZ7voif6CCrzWW7s08KKmBI6q//K4jz904rToGJXHcGUbsr9tB9nIRmktISE
         z6mMJ9gEB3S0z7MNM59U39LWle7wziBxQuwNXxSS7Flu4BAN1zpNSyPTqn/W7qGXjHC2
         5WqQngo+2R8wLf/np7yWpSeWOLkbL9KYa6kRp7twiKsCs2qGgpjn2f8ajgDUzT9LNxye
         MyQGepC7X0ziT4pMouR+wCZUu16bnUbQf0ZoKxMUGi4sNv5LLXyyMnUyiflfew+Cb5J9
         VxIg==
X-Gm-Message-State: AOAM531mT9+jObQKJ+k67UiwErQlDZcqtMHPY7iiAJvPVqF+ep3Fat9f
        fl3hZ136uSnmBIYEOP/Us6tT0zhKStqvQg==
X-Google-Smtp-Source: ABdhPJzvh+m/nd8X0LWdb0OOJ3lf3Yc2nk8BVWJNYj4OOpUFWlLWO95n+Pi7qT+ylP/ZABIe/QtXOQ==
X-Received: by 2002:a05:6402:84b:: with SMTP id b11mr2795030edz.69.1638313674363;
        Tue, 30 Nov 2021 15:07:54 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id kw10sm9518671ejc.71.2021.11.30.15.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:07:53 -0800 (PST)
Date:   Wed, 1 Dec 2021 00:07:51 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Jean THOMAS <virgule@jeanthomas.me>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 1/2] arm64: dts: Place LG Bullhead generic code into a
 DTSI file
Message-ID: <Yaaux8Vlq4+VUcGV@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
References: <20211130225645.171725-1-virgule@jeanthomas.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130225645.171725-1-virgule@jeanthomas.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

> This patch puts the generic code common across all hardware revisions
> into a DTSI file.

> It also prefixes the DTS filename with the vendor name, to follow the
> naming convention used by other DTS files.

Maybe nobody cares, but IMHO it'd be better to put the rename into separate
commit. Otherwise LGTM.

Reviewed-by: Petr Vorel <petr.vorel@gmail.com>

Kind regards,
Petr
