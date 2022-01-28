Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B622649F5A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347320AbiA1IwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:52:12 -0500
Received: from foss.arm.com ([217.140.110.172]:58788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238669AbiA1IwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:52:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FD9111D4;
        Fri, 28 Jan 2022 00:52:11 -0800 (PST)
Received: from [10.57.12.131] (unknown [10.57.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10D553F793;
        Fri, 28 Jan 2022 00:52:09 -0800 (PST)
Subject: Re: [PATCH v2 1/2] cpufreq: Reintroduce ready() callback
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220128032554.155132-1-bjorn.andersson@linaro.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <f539ca2b-22c4-5708-ddd6-4b638dc0655d@arm.com>
Date:   Fri, 28 Jan 2022 08:52:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220128032554.155132-1-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 1/28/22 3:25 AM, Bjorn Andersson wrote:
> This effectively revert '4bf8e582119e ("cpufreq: Remove ready()
> callback")' (except the Chinese translation), in order to reintroduce

Is there something wrong with the Chinese translation that it has to be
dropped? Someone has put an effort to create it, I'd assume (and also
based on online translator) that it's correct.

> the ready callback.
> 
> This is needed in order to be able to leave the thermal pressure
> interrupts in the Qualcomm CPUfreq driver disabled during
> initialization, so that it doesn't fire while related_cpus are still 0.

If you are going to push the 2nd patch into stable tree, then you would
also need this one.

Regards,
Lukasz
