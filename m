Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819B747AEF2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbhLTPGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:06:37 -0500
Received: from mga03.intel.com ([134.134.136.65]:25532 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240266AbhLTPDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:03:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="240139776"
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="240139776"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 07:03:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,220,1635231600"; 
   d="scan'208";a="507712429"
Received: from ksulliv1-mobl.ger.corp.intel.com (HELO [10.252.58.34]) ([10.252.58.34])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 07:03:26 -0800
Message-ID: <4de5b255-4f2d-870e-a7f2-05f5c0069cfe@linux.intel.com>
Date:   Mon, 20 Dec 2021 16:03:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.4.0
Subject: Re: [PATCH v8 0/6] Add Unisoc's drm kms module
Content-Language: en-US
To:     Kevin Tang <kevin3.tang@gmail.com>, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, pony1.wu@gmail.com
References: <20211207142717.30296-1-kevin3.tang@gmail.com>
 <CAFPSGXaC1rMF+KLttBJvKzN=UxtFtRR1gO3L4cqdgPJu_jtQ_A@mail.gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <CAFPSGXaC1rMF+KLttBJvKzN=UxtFtRR1gO3L4cqdgPJu_jtQ_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-2021 14:55, Kevin Tang wrote:
> Dear Maarten,
> I see it from the cgit.freedesktop.org, our sprd drivers seems has
> been merged into drm-misc.
>
> Now, what shall we do next?
>
> BR,
> Best wishes
>
> Kevin Tang <kevin3.tang@gmail.com> 于2021年12月7日周二 22:27写道：

You should apply for commit rights to drm-misc, so you can maintain it.

https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html

~Maarten

