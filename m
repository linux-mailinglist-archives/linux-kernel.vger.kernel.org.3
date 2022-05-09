Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60D51FC49
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbiEIMPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiEIMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:15:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8ED14A25D;
        Mon,  9 May 2022 05:11:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652098274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azpewdwyr1bDmpn1HTMmZ9HZHXGFtPT95Bi3ep9m4fU=;
        b=vBRHlPnl5xDIhHDIHNVzv9T+v1RKY6WkBo52fMHuIVQmg/hc7oZYgIuoRPa7kWYgNwp3dU
        uFQ5zabmE+nnDplq7WK+P9N964ou7YU8aca+msKAtFOx6tVhQpxxAplL5k/PLRoi7jjVRo
        QBokAUK9ECysANDWZFOX4zL0du4bLCX5HeMqBNbp8xbk7cwmiTgdEjvQH9crPoRna8XlKm
        rO8Z23ljW9OInHn4Bx1Q3+4eMzwFGa58wUDsJxhGrxPPzsQHn3LSyvKJ9mvwzkHV0uVIDX
        Q1sd+t3P6LEF8ETZvllWofJVIJW3i2GX8tH6XFJWVVPK4URxcWOaYGe+7AO0qA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652098274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azpewdwyr1bDmpn1HTMmZ9HZHXGFtPT95Bi3ep9m4fU=;
        b=Fa8LWCVkhpeu9m58BXxLAYB5dyjrVQfXlBW/0MxqCqwLqvv1fLtbYFSwhCkbv6vE1bz0d2
        ipJdkCbAdtHtw+DA==
To:     Tony Luck <tony.luck@intel.com>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        jithu.joseph@intel.com, ashok.raj@intel.com, tony.luck@intel.com,
        rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v7 05/12] platform/x86/intel/ifs: Read IFS firmware image
In-Reply-To: <20220506225410.1652287-6-tony.luck@intel.com>
References: <20220506014035.1173578-1-tony.luck@intel.com>
 <20220506225410.1652287-1-tony.luck@intel.com>
 <20220506225410.1652287-6-tony.luck@intel.com>
Date:   Mon, 09 May 2022 14:11:14 +0200
Message-ID: <875ymesy71.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06 2022 at 15:54, Tony Luck wrote:
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
