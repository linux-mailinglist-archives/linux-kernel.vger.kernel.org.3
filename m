Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF046AB17
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356144AbhLFV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 16:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356122AbhLFV6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 16:58:51 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEEDC061746;
        Mon,  6 Dec 2021 13:55:22 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b1so28641054lfs.13;
        Mon, 06 Dec 2021 13:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uU7KIRhPFSUlmaUaEvX8bGN6Gm4s3bRzUE8sJ3SPRAY=;
        b=qxnkbniv6ZYsnFo/K/cjtP43BFmcGu+txxWdboF+cZZ7TdAVxF3PYI6kD/K5+cdJPA
         MSGau8OpcwKxPQvSjDzJFAmxHbSFG0X91Y7T9rZXayYEnzHIfFJ/g3yk49HkZHxM4OUS
         QmLV3HuRFtoEbgpHgRpn/7Ov133SG3T6LW9Y7kZ0NFSGn9L9QnkjHV9Z1WCebDapoERM
         X77IdharlzmcQ1zL4lRd/Dv8EpX6ywkZYA5VEI0ELJM86FIFl0KWlKbTZmjvyeECSzRr
         5KHc3D8qxL8HxaLK7rqdvtypvpmN1KkyBz55Kn2HfhBvdJyuyBfl4Z7qNHlDyl17sGAh
         x1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uU7KIRhPFSUlmaUaEvX8bGN6Gm4s3bRzUE8sJ3SPRAY=;
        b=148lKRh6mFeGqPC/KjRteSU/BLNjLW1B1k9FG7ADmqgF08VlHzWDaxAaTOj9GhGs/W
         MsnNZ3Wk69qgg9k8dq2hCWpL/noAgoEnpSIAzQcqJT/CX/mlTIjRNLVBxl4eqMcMDnvr
         +LgRQOveAzh3EUfrkx9VWRmn96rFSjubYkHgifEYQZ33bSf+eVaa5f+2+ReXYqA5own5
         cHMqNhGRSHrauKRJG0266CbHTz+tPRAG140V7kS+/FnAJEVb9wag/UycuIoF9lZlMb7/
         hySYt3orPNej9hIJcW4GV9pWi/3JhDh2iWHsv97wdYrXqBRV8tNIVGO+8FvbQeDqNiXI
         1zvQ==
X-Gm-Message-State: AOAM5320ORpQE6jdQ1cL8SgN7ACgbfAcPEmzqx5rEvjyULGTQJGKZ/xf
        3RGcnQnkw81159lJzZZSxtSGSjjjbik=
X-Google-Smtp-Source: ABdhPJyIrmPczp8pcoGokT+wh0kT+AXaBITOqG0DJq0Xdeo/QGVfaOw5ZKQVZEeC7+zXFbDChFcf2w==
X-Received: by 2002:a05:6512:39ca:: with SMTP id k10mr38179762lfu.426.1638827720166;
        Mon, 06 Dec 2021 13:55:20 -0800 (PST)
Received: from [192.168.2.145] (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.googlemail.com with ESMTPSA id z4sm1446018ljj.26.2021.12.06.13.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 13:55:19 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: regulators: Document Tegra regulator
 coupling in json-schema
To:     Rob Herring <robh@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211206154032.227938-1-thierry.reding@gmail.com>
 <Ya51Ndf+VdRRdM9h@robh.at.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dfb6b42c-16ed-ab17-b585-6b07d3d6874f@gmail.com>
Date:   Tue, 7 Dec 2021 00:55:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya51Ndf+VdRRdM9h@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.12.2021 23:40, Rob Herring пишет:
> On Mon, Dec 06, 2021 at 04:40:32PM +0100, Thierry Reding wrote:
>> From: Thierry Reding <treding@nvidia.com>
>>
>> Move the NVIDIA Tegra regulator coupling bindings from the free-form
>> text format into the existing json-schema file for regulators.
> 
> Do we need these properties for every single regulator? This should be 
> its own schema file and then referenced where it is needed.

These properties are SoC-specific, they describe how regulators are
integrated into SoC's power subsystem. Regulators themselves are
SoC-independent, i.e. PMIC's vendor and model don't matter for SoC.
