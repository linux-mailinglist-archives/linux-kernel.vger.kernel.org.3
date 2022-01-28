Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A40849F56A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347564AbiA1IhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243171AbiA1Igl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:36:41 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02525C061751
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:36:41 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so1291092ooq.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 00:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dlVldSaQlH4t9NEwC5BJsEDZ+tVQfSlVuaFbSGbnynU=;
        b=GlqQSupVUbJsQqeS0RNPjonpzLoOH5zB66C9gpbcqeBD2zoXkgl85gMKZMf/m4rOFx
         8sU3o7jrNS7IZqfg+ce8xDjgpDz6v3vgS+mVrATuhQnTSjBlXBTdjnpVkVK8LfL6Obqc
         j3RDF0QlS68pLW/Nc1n4crioKoyKJRR+zadnVtlcnsDsLSidsvf8pXXkB/JifYkkuDzc
         uxYyg4N+Wz7UX0PM6sv/x99xoVnxT/Qj2u3UMSYoUbTwf4J1vYDTNPYqajV8VG3Ku+Yj
         1//tzifYJqX79bj5VYa46UameZze8aJPOVUl8dO5xwkcEwBknZP/Ss1fjWc2gNb102DE
         ix2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dlVldSaQlH4t9NEwC5BJsEDZ+tVQfSlVuaFbSGbnynU=;
        b=MHQkcwY3QahjyJWw1wMNvYHMmVKvJ+RUW6pxLYuvQ/OwLqnlZIPe8LYYJDZE/0QCpM
         wf4KczQaVVtYSZac9yVTfJh55OArXF40KJKZRUllrAssT7aB/Nfpmb6TagWaI4m9q5TL
         QxaOjLXg0pf6y11dj6nqdxqNQA0GSZvjcQGmx6/lxk01PoA6d9fTPv+eXeFMiF9aC3ch
         NwKGC4HREzWRjAlT79epFK3mzm933tckfVfTH62QpJHEmF2L8xj6p+XSUDS8LqJYp+Sb
         FhyyXlSqrAYZ9aV+l7NuHF3l87sAfbsgFvDMTtDQI+f+0iwNxu4lhVDiehJ+W3CxDIzO
         E/Iw==
X-Gm-Message-State: AOAM532nrHPnBUJsGxipmrMH/rOesvdYt6gGlRCuRmnIWdy3ABZzQdGY
        CUkmoY9chu/5blfWoitFXa/5dQ==
X-Google-Smtp-Source: ABdhPJzXtnHET6jvGK73tLcdq7BSTd9anw1mJoWiv6ss36LfRT6NGLqUqlXglkszW3Oj3gJqWIqGCw==
X-Received: by 2002:a4a:e0d8:: with SMTP id e24mr3770200oot.56.1643359000373;
        Fri, 28 Jan 2022 00:36:40 -0800 (PST)
Received: from [192.168.11.51] (cpe-173-173-107-246.satx.res.rr.com. [173.173.107.246])
        by smtp.gmail.com with ESMTPSA id a8sm2463920otj.47.2022.01.28.00.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jan 2022 00:36:39 -0800 (PST)
Message-ID: <52b37547-3e78-b18c-307d-7eedf5baab0d@kali.org>
Date:   Fri, 28 Jan 2022 02:36:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v10 6/6] usb: dwc3: qcom: Enable the interrupts during
 probe
Content-Language: en-US
To:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com
References: <1642398248-21753-1-git-send-email-quic_c_sanm@quicinc.com>
 <1642398248-21753-7-git-send-email-quic_c_sanm@quicinc.com>
 <93b68251-7e7e-ac92-fb47-346c410744b2@kali.org>
 <20220118095255.GB11385@hu-pkondeti-hyd.qualcomm.com>
 <78c90e46-666b-bc9b-235d-ae4c69e19929@quicinc.com>
 <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <601cdc74-392f-dd4f-7ea0-8e65c6b6d7e2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandeep,

On 1/25/22 3:17 AM, Sandeep Maheswaram wrote:
> Hi Steev,
>
>> I didn't face any such issue with devices connected.
>>
>> I think this is because I used IRQ_TYPE_EDGE_BOTH in device tree and 
>> Steev has IRQ_TYPE_LEVEL_HIGH in his device tree.
>>
>> When i changed to IRQ_TYPE_LEVEL_HIGH I also observed a storm of 
>> interrupts in my device though it booted .
>>
>> Regards
>>
>> Sandeep
>>
> Can you try with IRQ_TYPE_EDGE_BOTH in your device tree and see if you 
> are getting the issue.
>
> Regards
>
> Sandeep
>
I just tested here, changing both of the IRQ_TYPE_LEVEL_HIGH in the 
yoga's dts to EDGE_BOTH and I still do not get a booting system.

-- Steev

