Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A2C475E35
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245163AbhLORIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhLORIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:08:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9071C061574;
        Wed, 15 Dec 2021 09:08:36 -0800 (PST)
Date:   Wed, 15 Dec 2021 18:08:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639588115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RI8NLXBUCWsXJabSzD5c5VTKqgHlJN50jp2SThaAlXc=;
        b=DxHvAalkg++Zn0R80iHIQ4Xpmrdjf7v6DAqL3ye13+7TqIrrYCactnCf6KPkPlEBHGo53h
        W1I3RB+4hNHm78b5S0hRr2iPVEkmfM0fbT64ANsyaF+6dWSVNZRfozN5DIU5LW7D5O6PsM
        RFelWyRbmcJhe0zAN5KpYkpuFuwKKnM+a+F/zzWfYKxgveaWkXw7x7qxUnEMEZLdS1nNzZ
        JwUy5iWfva7jcY4ThqG+SzXYQqpBlvbB8jUxecI2LJKu04uWTb2N9Zmvq1OasgVfPbrOPv
        xwuK+7lVb7TNiQSdgyG4PA4r7QOz+dsGww3Qq0p8DCerH+DwxFYMarlr/W2SDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639588115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RI8NLXBUCWsXJabSzD5c5VTKqgHlJN50jp2SThaAlXc=;
        b=jJXB+Q46v7yLP8dOYOTa+t+wB8UmkL02k8pjmEyvTMgeIFBnprLsryCqmnYxfmK3jjsmXV
        bE0ePC6/F3fIPRCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2 2/2] blktrace: switch trace spinlock to a raw spinlock
Message-ID: <YbohEio+66fyFo6D@linutronix.de>
References: <20211213123737.9147-1-wander@redhat.com>
 <20211213123737.9147-3-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211213123737.9147-3-wander@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-13 09:37:37 [-0300], Wander Lairson Costa wrote:
=E2=80=A6
> To avoid this bug, we switch the trace lock to a raw spinlock.

Steven, do you think this is a good idea?

Sebastian
