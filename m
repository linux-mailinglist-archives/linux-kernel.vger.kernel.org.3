Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8BF4DB58D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiCPQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357481AbiCPQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:03:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9ED3DDFD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647446517; x=1678982517;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=fA5HguUpbzGH5dmq8G/+lEaDgPCt6fNMrRQguFHsKFw=;
  b=d7jQ3Rwbl8qRf83s7F7PBmxmRfdT8XLpYM4BNM3wLPvp39h8y2kwlac7
   ZfYg29UxiWTF+i3gzPk+5wPZjFkrrjWQ7U0sQzFnhVtzQpzplIKe0c/PB
   tf/Jfam2i3jJIFe6aiI/NwL8LwHep0NsPCYAeyzwng2AiUytc7egVN90w
   PsyGv0osYtspIgaHQie1jcBvf2jz5c78zTGLO0Tl4ddLldhvMC4v3OEmg
   JTJws8UVYyKybl/TS4oIWjbQXtkklGp7y3XutyvWFDuMPhNUrEdxS6xkB
   kpoK+buwwXrO2doGxa6z47wYjLvkyAWKz6PtitBSGduEO5ClbFzko4tTU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="343075775"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="343075775"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:58:11 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="613691627"
Received: from jdwaldem-mobl.amr.corp.intel.com (HELO [10.255.228.230]) ([10.255.228.230])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 08:58:10 -0700
Message-ID: <f1c36202-9794-31f4-eab8-e886728002da@intel.com>
Date:   Wed, 16 Mar 2022 08:58:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     =?UTF-8?Q?Borys_Pop=c5=82awski?= <poplawski.borys@gmail.com>,
        luto@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <9b82908f-eed1-b6b7-62aa-ecbba7bf048b@gmail.com>
 <f671c80f-f97d-b3a2-0253-2eec21e2c748@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: VDSO is randomized even when ASLR is disabled
In-Reply-To: <f671c80f-f97d-b3a2-0253-2eec21e2c748@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/22 04:42, Borys Popławski wrote:
> I would like to get some feedback on this issue. Would such fix be
> accepted? Should I send a patch?

The best way to get feedback is to submit a real patch following all the
rules in our documentation.  Cc'ing all the maintainers of the code and
testing your fix would be two great places to start.
