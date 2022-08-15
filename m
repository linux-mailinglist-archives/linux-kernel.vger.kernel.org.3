Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC6A592BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbiHOJ2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiHOJ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:28:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7CB1BEAC;
        Mon, 15 Aug 2022 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660555724; x=1692091724;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/ZB/bqkS16wIpUYRzAIn8dYga5U2Lc9wCDdIGKNXATg=;
  b=P5vSBMLEDt/d4qBNuZo4XiR3n9fusaQZ2i6SBpY95HokeGbf63i0dGZW
   HaLXT8AbzGOsPx0uhoHAyybn/I4LwoRH6uV/CwPLncwYQ999Xr2Ii7fOE
   luNRt0KsTDeX7zL2X4acXX8g9rsoy6xFwtHS4UvtnkSjnj3ok8xCMp+5h
   Q3BfWPkCRSewBoUkIKfzyJCrfB6HXtIHbbA0+g7dB1i5Mk3T/efFc+Yf4
   9GbtI+QAX4wPP3unif8AprtQ2aFhxJeRLLkHFUNdjpqmuJauqOYN5/ItH
   BI0Izma7/l6Jy1oxYhj3jJwRzXm+DijyNr3YM7JlCKYMxbcU3SnxeI9nF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="378214453"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="378214453"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 02:28:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="666602713"
Received: from abelova-mobl2.ccr.corp.intel.com (HELO localhost) ([10.252.50.172])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 02:28:40 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     min tang <tangmin@cdjrlc.com>, airlied@linux.ie, daniel@ffwll.ch,
        srinivas.pandruvada@linux.intel.com
Cc:     min tang <tangmin@cdjrlc.com>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        platform-driver-x86@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] drm/i915/gt: Unneeded semicolon
In-Reply-To: <20220813151616.4193-1-tangmin@cdjrlc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220813151616.4193-1-tangmin@cdjrlc.com>
Date:   Mon, 15 Aug 2022 12:28:38 +0300
Message-ID: <871qthsvnd.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Aug 2022, min tang <tangmin@cdjrlc.com> wrote:
> There is no semicolon after '}' in line 648.
>
> Signed-off-by: min tang <tangmin@cdjrlc.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_migrate.c         | 2 +-

This part is fine.

>  tools/power/x86/intel-speed-select/hfi-events.c | 2 +-
>  tools/testing/selftests/timers/nanosleep.c      | 2 +-

These need to be split out and sent to their respective subsystems.

BR,
Jani.

>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/intel_migrate.c b/drivers/gpu/drm/i915/gt/intel_migrate.c
> index 2c35324b5f68..a69b244f14d0 100644
> --- a/drivers/gpu/drm/i915/gt/intel_migrate.c
> +++ b/drivers/gpu/drm/i915/gt/intel_migrate.c
> @@ -645,7 +645,7 @@ static int scatter_list_length(struct scatterlist *sg)
>  	while (sg && sg_dma_len(sg)) {
>  		len += sg_dma_len(sg);
>  		sg = sg_next(sg);
> -	};
> +	}
>  
>  	return len;
>  }
> diff --git a/tools/power/x86/intel-speed-select/hfi-events.c b/tools/power/x86/intel-speed-select/hfi-events.c
> index 761375062505..f0ed69721308 100644
> --- a/tools/power/x86/intel-speed-select/hfi-events.c
> +++ b/tools/power/x86/intel-speed-select/hfi-events.c
> @@ -144,7 +144,7 @@ static int family_handler(struct nl_msg *msg, void *arg)
>  			continue;
>  		res->id = nla_get_u32(tb2[CTRL_ATTR_MCAST_GRP_ID]);
>  		break;
> -	};
> +	}
>  
>  	return 0;
>  }
> diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
> index 71b5441c2fd9..433a09676aeb 100644
> --- a/tools/testing/selftests/timers/nanosleep.c
> +++ b/tools/testing/selftests/timers/nanosleep.c
> @@ -72,7 +72,7 @@ char *clockstring(int clockid)
>  		return "CLOCK_BOOTTIME_ALARM";
>  	case CLOCK_TAI:
>  		return "CLOCK_TAI";
> -	};
> +	}
>  	return "UNKNOWN_CLOCKID";
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
