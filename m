Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2EA467EB5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383051AbhLCUTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383047AbhLCUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:19:39 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824EEC061354
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:16:14 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so2871892plf.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GXKTyzcsLJq6+rvHMa7KAK3ctXnwbY+JpVAXKVrBvSQ=;
        b=CEAOySlnXV8OrmUUrbXZ0UVeBUvTbhQEZKWtZpXbt3tvLq/A75O0DWf2A7RhdYjGph
         QO8qByuo6QRxOTE3zal9ObLqM6UxPzj498FljRaRD0thK8Amvxk+wi636uMpaKv6pC87
         OUV4w9QuO98Cw0ZR/Nt/I19cXMIG3GCepqIEwx7iojsi0sZp0BK1u4VlYbYN6sywfZN7
         8Se57yA2ON6oqfJQnwnTLJQskny4CUJ0Tsbweq+7Y/+g+DsyQt+8WC1YMmRxJas0ckvE
         KE1rVQB1uVvKFHC7bRWf7hEqTIhEg8C4JvqE6TAw7PaelAp4GO8//bfeluI6oMy4RJXC
         p9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GXKTyzcsLJq6+rvHMa7KAK3ctXnwbY+JpVAXKVrBvSQ=;
        b=rEjuOUCxb2o03NDTAno0D/ImJLsT4UAFVnPrVjWKmdfV4IPXjmcikhv7hvlozTGc2j
         hcXna4ZUETMKLUp9Jb/viiDiztXu0fwdir8JuwAO6i48EXJitMjshODYD19xvM/FMEkJ
         lVDr8sPSc3vMiDpuycKtbDXNpglUy1jYPvLBGVbJN6utS8vdS20JJ1EItgCQ5wgmd35Q
         XiBZJuodldRW61KrAmvaKNR5tHToMIgN1Xx7WNKHCbEgV2iSW96hi7+tQnENihLwLhgi
         5N4DMVRHrKV1cbKswl+9IHrKZUNSW/oYYXfHb/p1mB4WxhP63VDPzC/rb+uNhSuGTCk0
         PEvg==
X-Gm-Message-State: AOAM533jGSWQambF8n9YjYYNTNMpDCaw8fO75u2ELCEiXa4fsDwF/s2p
        HK2ml2QY3tUWkaogNw5j8uA=
X-Google-Smtp-Source: ABdhPJyu+cFc6MBt6+waeOhSEAl98PWwUKk1AK6amE4QU0pj7unhLqO5skUzC8bevm1/LcENfniuVA==
X-Received: by 2002:a17:902:e88a:b0:141:dfde:eed7 with SMTP id w10-20020a170902e88a00b00141dfdeeed7mr25458935plg.17.1638562574052;
        Fri, 03 Dec 2021 12:16:14 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ne7sm6061799pjb.36.2021.12.03.12.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:16:13 -0800 (PST)
Subject: Re: [PATCH v7 05/16] firmware: arm_scmi: Use new trace event
 scmi_xfer_response_wait
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-6-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5651bdbf-0a38-a5d8-c35a-e69849fe2bd2@gmail.com>
Date:   Fri, 3 Dec 2021 12:16:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129191156.29322-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:11 AM, Cristian Marussi wrote:
> Use new trace event to mark start of waiting for response section.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
