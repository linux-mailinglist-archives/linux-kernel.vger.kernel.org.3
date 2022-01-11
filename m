Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8842948B581
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 19:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244083AbiAKSN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 13:13:27 -0500
Received: from foss.arm.com ([217.140.110.172]:50348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243842AbiAKSN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 13:13:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B059D6E;
        Tue, 11 Jan 2022 10:13:26 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC9F3F766;
        Tue, 11 Jan 2022 10:13:24 -0800 (PST)
Date:   Tue, 11 Jan 2022 18:13:21 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com
Subject: Re: [PATCH v8 00/11] Introduce atomic support for SCMI transports
Message-ID: <20220111181321.GC6113@e120937-lin>
References: <20211220195646.44498-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220195646.44498-1-cristian.marussi@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 07:56:35PM +0000, Cristian Marussi wrote:
> Hi all,
> 

Hi

this series has now been partially queued (01-->08), the remaining
patches on virtio polling and SCMI CLK atomic support will be posted as
a new small patchset in the next cycle.

Thanks,
Cristian
