Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B3259FFE2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239413AbiHXQ5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiHXQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:56:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3772F01F
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661360205; x=1692896205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yIeg50QGVGV9KR+hBYBpbsyTfpcE1Tvc7wzp43fS3Xw=;
  b=RffCpPiI4Ie9w68CXqtqibN5+CeQmoryRzf+LTz/RyLEyn/A7Bs71lQx
   I9qYYy1264mSW9WqNZ2v45AONd38ESQMmoqVu6med/VClJPV13xZPDGhI
   6U1Quc6IJtozjgggFjNjiDKdDxRkWJDDxXH5ZG/ZKJxEvEwubHPyBhwew
   J/bUjP4V12Ov3xAo3dPjK/KhU4OHjMwyUFCXRnkqAjOaP0ZvtmSiOmxVX
   oaErIzgST9BcPOcc3sWjnYMWykdCaODX4UeMCE4zXSYk9cXIXWdir1kpP
   Bd/Qnqi/Xrv4iUCZr3JHTwSA3ho9nOodwTeANaEv3sF0/hhh97w+uUMO0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="380311767"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="380311767"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:56:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="586508467"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.241.236.13]) ([10.241.236.13])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 09:56:44 -0700
Message-ID: <b08a8d19-66b7-b3cc-e994-d0b0b533bfa0@linux.intel.com>
Date:   Wed, 24 Aug 2022 09:56:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/5] perf record: Allow multiple recording time ranges
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-kernel@vger.kernel.org
References: <20220824072814.16422-1-adrian.hunter@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220824072814.16422-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/24/2022 12:28 AM, Adrian Hunter wrote:
> Hi
>
> This patch set extends perf record -D/--delay option to accept time ranges
> for when events are enabled, for instance:
>
>      perf record -e intel_pt// -D 10-20,30-40
>
> to record 10ms to 20ms into the trace and 30ms to 40ms.  Refer patch 5 for
> more details.


Great! I just needed that for something.


-Andi


