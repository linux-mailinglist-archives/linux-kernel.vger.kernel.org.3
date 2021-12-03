Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B463D467EBA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 21:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383067AbhLCUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 15:21:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhLCUVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 15:21:03 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB55C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 12:17:39 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z6so3891598pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 12:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yDKwAIv5I0qh5LDuY/of0nrbA0c0e85ddJwi4pLRTuk=;
        b=je/rrTZ7bwKxPu2DDChs6u+v8gk9EVrp1ah9RtgrQg7WRhGE411H+Sdxcw3ZV9X8NS
         PFWOtXa2boF655A2nNbPrz8wwVXj6Yt1c0J+nvEXekjcEoaaESNr0d3LMv5y+D5UIrie
         720VmfSvWRKEV5tcvMjHA9whtJajpOEZaIOqGe7CBIXFeBUjKw8dHX6drUxrcxbjOIEy
         eFIAg3+9j2nasCo0MvIMSC5+YmLtbFDzYaBaYgL8rgsiQFhkZISJj4bF+YPOn2CpBdpy
         /+2phNO9y/+QwuG1fl9cOr4AFgDRf10k7FjWBg4IYGOsSpb+ehI+dM7SArpKFrKQoYdj
         FXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yDKwAIv5I0qh5LDuY/of0nrbA0c0e85ddJwi4pLRTuk=;
        b=1D59BkbqBkjRSArHq52DoB+nuhzJKXeoHUDXsKt0wBFH3alA8uA1RB0xwy+Gh4pZ7D
         uOIg21wN2vGtbq9Bn8XFyyeejfHWtrunRfZGEysD6JGc1WG8DJCj6PIYekhUncLfOZJq
         437bK5YEHRgOb2ARK8fG/0MdLWlirSSrRNa0gHqG2d471EM0EiuE3K1P7CHyU/qWcs05
         J/kztgY7bFADJ/r1Fsb6392uu8OfZGtoZO2GkJmxrNAUXlrCnUhiMMXainj0Vfd7oQy2
         +pN9O3htK9OSftnHhVZVse+wcMNZBXvTkzyHXDa6ltbYJEaT+n/RIJh5d10g+9tNx0U9
         UGdg==
X-Gm-Message-State: AOAM532dWHQNbn/h0I8OnN1UxOP3qkXIjMpKYOUDrfOykbISH9oBRn+6
        HR+Hd5uk/xE6aiLSrLdcj5M=
X-Google-Smtp-Source: ABdhPJzLhsPdf7ZWYDif7PWiyy/6YVXmfwLrKhyjXi9PI2IN6jvNT07ItalAAnbby/0q4vxc1l/jYQ==
X-Received: by 2002:a05:6a00:1514:b0:49f:b5ef:affb with SMTP id q20-20020a056a00151400b0049fb5efaffbmr20858069pfu.7.1638562658878;
        Fri, 03 Dec 2021 12:17:38 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t67sm4078947pfd.24.2021.12.03.12.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 12:17:38 -0800 (PST)
Subject: Re: [PATCH v7 13/16] firmware: arm_scmi: Add new parameter to
 mark_txdone
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com
References: <20211129191156.29322-1-cristian.marussi@arm.com>
 <20211129191156.29322-14-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <642774a3-d4e8-1ed3-65c9-adc0cc4423ee@gmail.com>
Date:   Fri, 3 Dec 2021 12:17:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211129191156.29322-14-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/21 11:11 AM, Cristian Marussi wrote:
> Add a new xfer parameter to mark_txdone transport operation which enables
> the SCMI core to optionally pass back into the transport layer a reference
> to the xfer descriptor that is being handled.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
