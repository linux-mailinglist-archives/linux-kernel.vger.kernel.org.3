Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6554CF14B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 06:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiCGFpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 00:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbiCGFp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 00:45:29 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481AE4B1E4
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 21:44:35 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fs4-20020a17090af28400b001bf5624c0aaso2073579pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 21:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0KJ1UjrBbg7fzlE37vFvidwoVO0sq5aEejs8cXRFhtQ=;
        b=mM6xhWXMHsiD6hkKquVoAp9riwKGW4Y0BUxcomfYBDTYo+XYnAaD+BZgNnyTjL1AWU
         zejG8GBilDqTTvMTR9QQsw7JxCWOwgBHhxRj2VIZz5y14GgPIVd3bWy82oMmFcQgrEt7
         FAcSMxYLv1YblrYNnz7KkCe6QEdcqzzzCeUjBzfBVt3POJ82ENLAf9aW0PaJYI0RPRm/
         ToMG8C1rNpRf5e5kpzM0ijml7vjzLWhvD6kb+Ps/hm5HTdQP9WzTXJKR5wwqgAbsV1bW
         fTbwgyihZy1rFq33m1CA2wRAY1+sK15eSn0nku684U0fntRocSnkU7d+7VCN5Li96AWg
         WIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0KJ1UjrBbg7fzlE37vFvidwoVO0sq5aEejs8cXRFhtQ=;
        b=M/hNbm5WKWCJf5SDf9rzm6f15GeHWUJCAwWknr5LhghwqUlr6PgwbUcJoBPKLCuEda
         aMxc0gdYPD4A3e0B9zKafO2rWt2qfhC6QLsIz1X6ypFIOZVQdRKRgRpqUI4pQ8hu569U
         OAGzKVuWbXGnS9XvpMxZ7zTu6w9m6fAXINcbJNxa2t+D/h9+ju022m2YRjVAv9b3NWZ4
         aByXmSGf5YKF76vIjkyMyjwvFCiflutGRgAMOuuPZ8Y+SwnXuVkpStyHGog+6W2eLmFo
         k3yqNbWI0WNPEPVAaKXawSz3kUNpyJ5lLAAVEcM4x/RFk07FyJGgGkxziLrvImaXjHwE
         +Abw==
X-Gm-Message-State: AOAM531eyVI8wXIQ5l/v034QrtgT1sOYHua/mf7ao46nWrsHmeVPtvRe
        NpziK+v5F+13Hh28STfQ8DmkzA==
X-Google-Smtp-Source: ABdhPJzqYG18cC+N/uShcQuB2WbjyF/988f/94S+cZx93mrfz490W8VRJXux93FuMHauXjmvrnU4TQ==
X-Received: by 2002:a17:902:f789:b0:14e:ebbc:264b with SMTP id q9-20020a170902f78900b0014eebbc264bmr10491053pln.169.1646631874829;
        Sun, 06 Mar 2022 21:44:34 -0800 (PST)
Received: from localhost ([223.184.83.228])
        by smtp.gmail.com with ESMTPSA id c11-20020a056a000acb00b004f35ee129bbsm14767184pfl.140.2022.03.06.21.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 21:44:34 -0800 (PST)
Date:   Mon, 7 Mar 2022 11:14:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     zhanglianjie <zhanglianjie@uniontech.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] cpufreq: use helper macro __ATTR_XX
Message-ID: <20220307054432.amawi7afl3vudfjn@vireshk-i7>
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
 <20220306021250.64315-2-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220306021250.64315-2-zhanglianjie@uniontech.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-03-22, 10:12, zhanglianjie wrote:
> Use helper macro __ATTR_XX  to make code more clear.
> Minor readability improvement.
> 
> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
> 
> diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
> index 65ecf32ba4f8..a5a0bc3cc23e 100644
> --- a/drivers/cpufreq/cpufreq_governor.h
> +++ b/drivers/cpufreq/cpufreq_governor.h
> @@ -68,12 +68,10 @@ static ssize_t file_name##_show						\
>  }
> 
>  #define gov_attr_ro(_name)						\
> -static struct governor_attr _name =					\
> -__ATTR(_name, 0444, _name##_show, NULL)
> +static struct governor_attr _name = __ATTR_RO(_name)
> 
>  #define gov_attr_rw(_name)						\
> -static struct governor_attr _name =					\
> -__ATTR(_name, 0644, _name##_show, _name##_store)
> +static struct governor_attr _name = __ATTR_RW(_name)
> 
>  /* Common to all CPUs of a policy */
>  struct policy_dbs_info {

This change looks fine though.

-- 
viresh
