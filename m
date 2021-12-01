Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A3346545D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 18:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352032AbhLASAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:00:22 -0500
Received: from rosenzweig.io ([138.197.143.207]:49226 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351955AbhLAR75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 12:59:57 -0500
Date:   Wed, 1 Dec 2021 12:56:26 -0500
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dougall <dougallj@gmail.com>, kernel-team@android.com
Subject: Re: [PATCH v2 8/8] drivers/perf: Add Apple icestorm/firestorm CPU
 PMU driver
Message-ID: <Yae3Sqp528AB2XCl@sunset>
References: <20211201134909.390490-1-maz@kernel.org>
 <20211201134909.390490-9-maz@kernel.org>
 <YaepolizIKkzDQoV@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaepolizIKkzDQoV@FVFF77S0Q05N>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Add a new, weird and wonderful driver for the equally weird Apple
> > PMU HW. Although the PMU itself is functional, we don't know much
> > about the events yet, so this can be considered as yet another
> > random number generator...
> 
> It's really frustrating that Apple built this rather than the architected PMU,
> because we've generally pushed back on IMPLEMENTATION DEFINED junk in this
> area, and supporting this makes it harder to push back on other vendors going
> the same route, which I'm not keen on. That, and the usual state of IMP-DEF
> stuff making this stupidly painful to reason about.

Rules can be a bit stricter for vendors than for ragtag
reverse-engineers. The kernel community can push back on vendor's
choices because vendors have the power to choose otherwise.
But reverse engineers' hands are sometimes forced by bad vendor
decisions; rejecting the driver means mainline can never support the
hardware. I believe there's precedent for distinguishing these cases,
at least in the graphics subsystem.

I don't know if this applies to this driver. I only wish to offer a
rebuttal to a future vendor trying to mainline something questionable
with the defence "Asahi Linux / Nouveau / ... did it, so we can too".

(This will be relevant to the Apple M1 display controller driver, which
would be a hard NAK if submitted by Apple...)
