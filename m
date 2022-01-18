Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832DC491F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 07:51:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240131AbiARGvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 01:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiARGvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 01:51:22 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EFDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:51:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id q25so6512959pfl.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 22:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Sdzn4728y8mdGysaFo2LEHklvzQn6KM9voqPbKWk+Ns=;
        b=rssgcWd2+hvpvo2KePAMxGiWcZnx9TfVpCowmp19gRyk9HoKvPmjnOlP58wSWcy7bD
         qZQw6kfmbO08M8lGzmO14qCLeL19cdQPBMaZz2Vn1RgMgx++a/uQNLJtEtCrJqfBPysz
         hW0kYghQ/fQkMjEPHH0Pi8hO3qsRf6szjxh8ffGmBp9rEOdX9X4wSOBU+puqMaumGdx4
         kSfqCA6JgOl8a7cryPdh3GQvDW5zX7IqIElx69sinEu/tJZVn9jFR1bsys+Cnylr0H76
         P4Unuwgayox0M9hU+LmqyNfakUbOfYcf/B/0p1LIDp0EGStr3Hqcd4FM8Ot9xDweQ9BX
         pkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Sdzn4728y8mdGysaFo2LEHklvzQn6KM9voqPbKWk+Ns=;
        b=4KgL0VSO5q9eouQe5lV/OMBT+k+dTpW8TPmjDVK9q/4mR5tGb4fELEUQxyspfF0d1t
         8nLB+QPFB1vHpc5amBP0yC43N8wgSuuUYpV59GTs4lvenNbtpiO5sJsvKTtlsizyqIcD
         znMZxMHD898EuAAcT1Xd+lIQN5ADLpCiyTdjfKtl37awp9O1/+AS6sAGpx3czSCQ/oe6
         O0SRdr9UgsW5ITDaZgNDmajHfbgWMltQPjjfaY2soX96nzmId3MFfRausoit3A7SiWWm
         SXLWY2AKiITDwVKbtsRlW3XK0Sgz0YVb1lSU5JJK6H/cS+MlZ/yi79aXEJDXSk+4j5al
         kIsA==
X-Gm-Message-State: AOAM5320y8bcuDNX04jw5ghi3iSNjjQfOkMRUI26UMLwHzE3CeUltDqp
        Axxtk24wN1z0KS/K9iy1s9M8HCmbPQZSew==
X-Google-Smtp-Source: ABdhPJyg4CJ15cXRIoYFC/jUkDk+ekjCRBrBgKQYkjK5Da6zo9iFV6p29XFdC8rjs+Q+ZJM+iI1Kig==
X-Received: by 2002:a63:7783:: with SMTP id s125mr21595094pgc.462.1642488681847;
        Mon, 17 Jan 2022 22:51:21 -0800 (PST)
Received: from [10.16.129.230] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id m10sm1303965pjl.33.2022.01.17.22.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jan 2022 22:51:21 -0800 (PST)
Message-ID: <e31724fb-1758-15fb-6da8-5fbce51a3245@igel.co.jp>
Date:   Tue, 18 Jan 2022 15:51:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 001/001] UIO: allow binding uio_dmem_genirq to devices
 using command line options
Content-Language: en-US
To:     Alfasys <alfred@alfasys.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <qFul607Amxy21SnrHljzWlk1zF1aanKgSpEIH0--hvj9t9wRzQR5xx80eFgl_2I6pppi8NNFp0TTHwkQw0uQD0Xl-8vth8-KOsbfwrLIHNg=@alfasys.se>
From:   Damian Hobson-Garcia <dhobsong@igel.co.jp>
In-Reply-To: <qFul607Amxy21SnrHljzWlk1zF1aanKgSpEIH0--hvj9t9wRzQR5xx80eFgl_2I6pppi8NNFp0TTHwkQw0uQD0Xl-8vth8-KOsbfwrLIHNg=@alfasys.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/01/16 1:42, Alfasys wrote:
> Add an option to bind the uio_dmem_genirq driver to a given device
> using command line options.
> Make uio_dmem_genirq match uio_pdrv_genirq functionality added in
> commit 05c3e0bb5629 ("UIO: allow binding uio_pdrv_genirq.c to devices
> 
> using command line option")

A bit of a weird extra line break here, but other than that, looks ok I 
think.

Acked-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
