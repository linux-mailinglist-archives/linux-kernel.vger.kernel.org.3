Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA71353B0A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 02:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiFBAAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 20:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiFBAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 20:00:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C2329A637
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 17:00:45 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id b135so3300234pfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 17:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=dj5xSI3x7kYGymfT74GT+D5EgC5KBBiRdOQyucXrgA8=;
        b=BDEQtl4wDYFppmJ0FteRHhjnSzu730tXU7L8PyUwqpE8VTcccoPSo/aCpk1hfIEZ6M
         smyPyAncY17SE6CmMtsnP35N6zQBT+MjXGVM/2Y76G4slCjBMeToEr4Y0k3c7p7x/8j2
         xYziG5CerMPjkj2iVbzsBH183fRWTO1xpz9IrZkE5Rs3BHbxF0Eqe0lPQOo8oV0ondFE
         NDzi96z7nhvvWfDcr5SW4sBlG5MW8AECa7HoXhQyIkFGtRmE5pp/VnhFOhY6BbE+IB3B
         oCQI+aMwq4pMGlHxM+ll+YBzQkYStotkwhUhCz4jXo9cowL5ImVsu3FQcixpkAAxkWjL
         odEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=dj5xSI3x7kYGymfT74GT+D5EgC5KBBiRdOQyucXrgA8=;
        b=ICOvwrq9yZowOoaVKzw3eNC+x2TfrNRMAzB9YWIad8KMoV12Hzt/N0uaLUKVFxWsdM
         YOrz2a6UeGP0B55K1y601oz2jBhgFdt3YJ2gt+zOEFLO+bQrNdPebuDRkhvmgLJt6ksL
         PBYXg2rZerJftlv4trZl6dilTx+Z/ymrIAZDXnhZsmCc+UiIssS3p/LUCqwXBTzReh+p
         9zY5QZ0RgY/Gzr4pSwwMl/DhNFlYuQ04840tbAFWH6ERnrVD9p2B3vBp5JuS9bQm5okF
         BcB4yUq9FhhGMBlUlVWZ4dBY4re/yPLr/AaaRfCFfuCUCllTCyKUsA19717skl9ZMlyS
         C+9w==
X-Gm-Message-State: AOAM533WWYGNyb0p6yYGzxrH6aZ/+20Zyf32AhW6Zypjlv36hQtMXddH
        n6LN9iaR2t38HVuJHWi3Wg3CgA==
X-Google-Smtp-Source: ABdhPJyHR3+y0zXa9ywWcpnvwWALrHAEJQ8sj0rBRN8trB0V2gxf/dUBe0Vg8Z/OHWC5FuZ05iQVDA==
X-Received: by 2002:a63:6b4a:0:b0:3fb:b03e:d10 with SMTP id g71-20020a636b4a000000b003fbb03e0d10mr1635518pgc.310.1654128045457;
        Wed, 01 Jun 2022 17:00:45 -0700 (PDT)
Received: from [192.168.254.36] ([50.39.160.154])
        by smtp.gmail.com with ESMTPSA id b2-20020a17090aa58200b001e0a07497c1sm1882194pjq.53.2022.06.01.17.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 17:00:45 -0700 (PDT)
Message-ID: <c3bd8e63-7204-f86d-8efa-254db71185fc@linaro.org>
Date:   Wed, 1 Jun 2022 17:00:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Bui Quang Minh <minhquangbui99@gmail.com>
References: <20220525151517.8430-1-mkoutny@suse.com>
 <20220525151517.8430-3-mkoutny@suse.com>
 <20220525161455.GA16134@blackbody.suse.cz> <Yo7KfEOz92kS2z5Y@blackbook>
 <Yo/DtjEU/kYr190u@slm.duckdns.org>
 <0babd7df-bdef-9edc-3682-1144bc0c2d2b@linaro.org>
 <Ypf0VnKUMiuRgZqT@slm.duckdns.org>
 <1fb4d8d7-ccc0-b020-715e-38c2dfd94c23@linaro.org>
 <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
From:   Tadeusz Struk <tadeusz.struk@linaro.org>
Subject: Re: [PATCH 2/2] cgroup: Use separate work structs on css release path
In-Reply-To: <Ypf5jpI7dSmpi4W0@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/22 16:43, Tejun Heo wrote:
> On Wed, Jun 01, 2022 at 04:37:17PM -0700, Tadeusz Struk wrote:
>> Yes, but as far as I can see the percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn)
>> doesn't change the value of the refcnt, it just causes the css_killed_ref_fn() to be called
> 
> Yeah, the base ref is special for percpu_ref.
> 
>> on it. Only css_get() & css_put() modify the refcnt value.
>> And for the "free the thing" the css_killed_work_fn() does that.
>> It calls offline_css(css) and css_put(css) for the whole css hierarchy.
> 
> Yeah, the freeing path depends on the css_put(css) invoking css_release()
> which schedules the work item which actually frees. Am I misunderstanding
> something here?

What I'm trying to say is that it's not really a ref imbalance problem.
I think once the kill_css() has been called on a css, and it is enqueued to be
killed, we shouldn't call css_put(css) on it anymore outside of the "killed call
flow path". It will all be handled by the css_killed_ref_fn() function.

The fact the css_release() is called (via cgroup_kn_unlock()) just after
kill_css() causes the css->destroy_work to be enqueued twice on the same WQ
(cgroup_destroy_wq), just with different function. This results in the
BUG: corrupted list in insert_work issue.

-- 
Thanks,
Tadeusz
