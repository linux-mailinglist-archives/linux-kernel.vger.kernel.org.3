Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5275E47A786
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 10:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhLTJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 04:59:00 -0500
Received: from foss.arm.com ([217.140.110.172]:51796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhLTJ7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 04:59:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D11A1042;
        Mon, 20 Dec 2021 01:58:59 -0800 (PST)
Received: from [10.57.6.62] (unknown [10.57.6.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986EF3F718;
        Mon, 20 Dec 2021 01:58:57 -0800 (PST)
Subject: Re: [PATCH v2][RFC 1/2] Implement Ziegler-Nichols Heuristic
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        Chetankumar Mistry <chetan.mistry@arm.com>,
        linux-kernel@vger.kernel.org
References: <20211217184907.2103677-1-chetan.mistry@arm.com>
 <28c7a12e-6d85-d15d-8884-997eb68612e9@infradead.org>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <a78792dd-f755-59c1-57e5-a9ea9cc18d7f@arm.com>
Date:   Mon, 20 Dec 2021 09:58:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <28c7a12e-6d85-d15d-8884-997eb68612e9@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Chetan is on holidays and I'll respond to feedback.

On 12/18/21 6:07 AM, Randy Dunlap wrote:
> 
> 
> On 12/17/21 10:49, Chetankumar Mistry wrote:
>> Implement the Ziegler-Nichols Heuristic algorithm to better
>> estimate the PID Coefficients for a running platform.
>> The values are tuned to minimuse the amount of overshoot in
>> the temperature of the platform and subsequently minimise
>> the number of switches for cdev states.
>>
>> Signed-off-by: Chetankumar Mistry <chetan.mistry@arm.com>
> 
> The kernel-doc changes all look good and don't cause any warnings.
> Thanks.

Thank you for the testing it.

Regards,
Lukasz
