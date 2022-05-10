Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4F5226D7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 00:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236410AbiEJW2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 18:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiEJW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 18:28:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CED506C5;
        Tue, 10 May 2022 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652221718; x=1683757718;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=IfCJqds3yAbFKum7I8VqgabqC1CZEGfw83VIQGi4iPo=;
  b=bfHex7zjinGQRfC/JTJPj6VVxs9fLH75lSqDkE6GuUlMyYgZ+QeJZXZ+
   QZYDkvl6MLeg1j+45UgsbiPGYjlhsY1qhXGDjhVgyo7fCTPUlMd5f6tp/
   0aGzTIi799QK0DOJVaDfbEGBkPnyNZBreXISwqj3H3c7P8+dR52u0aIlG
   rsW+5ulhsCKlxn/AtbwOJewjGVzjgG0KivzrCQ2/gTyWkga1M+WsXjNtc
   /dWdfw+69IfJskph75uAKaN3eArFty/Aa8msEVNmtNGfd3bSAgy3Cm2yo
   3B7IB5kVYUBTcEMOMa7WWVljr43UAdv8ztUKrAlVbqsy+A82e8PAiyIlw
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="268360481"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="268360481"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:28:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="895082686"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 15:28:38 -0700
Date:   Tue, 10 May 2022 15:28:38 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Rob Herring <robh@kernel.org>
cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 3/3] arm64: dts: intel: add device tree for n6000
In-Reply-To: <20220510192201.GB2427587-robh@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2205101526590.885823@rhweight-WRK1>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com> <20220508142624.491045-4-matthew.gerlach@linux.intel.com> <eee2d4f6-703d-d3bb-3949-493f9d65f676@linaro.org> <alpine.DEB.2.22.394.2205100717170.612063@rhweight-WRK1>
 <20220510192201.GB2427587-robh@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 10 May 2022, Rob Herring wrote:

> On Tue, May 10, 2022 at 07:17:59AM -0700, matthew.gerlach@linux.intel.com wrote:
>>
>>
>> On Mon, 9 May 2022, Krzysztof Kozlowski wrote:
>>
>>> On 08/05/2022 16:26, matthew.gerlach@linux.intel.com wrote:
>>>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>>
>>>> Add a device tree for the n6000 instantiation of Agilex
>>>> Hard Processor System (HPS).
>>>>
>>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>>
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>
>> Hi Kryzysztof,
>>
>> Thanks for the Acked-by.  I will add your tag to a v5 patch set submission.
>
> Before I commented, why would there be a v5? TBC, you don't need to
> resend just to add tags. The tools (b4, PW) do this for us. But when you
> do send another version you need to add the tags as the tools don't look
> at prior versions.

Thank you for the clarification.

Matthew
>
> Rob
>
