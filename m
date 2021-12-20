Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8E247A93F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 13:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhLTMK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 07:10:56 -0500
Received: from foss.arm.com ([217.140.110.172]:53242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhLTMKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 07:10:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C0AA1042;
        Mon, 20 Dec 2021 04:10:55 -0800 (PST)
Received: from bogus (unknown [10.57.36.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B20133F718;
        Mon, 20 Dec 2021 04:10:53 -0800 (PST)
Date:   Mon, 20 Dec 2021 12:10:50 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Cc:     robh+dt@kernel.org, edwin.chiu@sunplus.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cpuidle:sunplus:create cpuidle driver for sunplus
 sp7021
Message-ID: <20211220121050.rnd3o7d5cksqbqnk@bogus>
References: <cover.1639971376.git.edwinchiu0505tw@gmail.com>
 <6092f5f372851e2d6bf12b4b23209558038b9fda.1639971376.git.edwinchiu0505tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6092f5f372851e2d6bf12b4b23209558038b9fda.1639971376.git.edwinchiu0505tw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 01:37:32PM +0800, Edwin Chiu wrote:
> Create cpuidle driver for sunplus sp7021 chip
> 

Based on the driver here, I couldn't understand why you can't make use of
existing cpuidle-arm.c driver

-- 
Regards,
Sudeep
