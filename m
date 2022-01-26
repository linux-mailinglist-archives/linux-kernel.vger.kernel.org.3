Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BE949C61A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiAZJSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:18:10 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:38632 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238938AbiAZJSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:18:07 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091806euoutp0116f2a981f29b254fcdab94f8c7f48260~Nx2d2uPqo2971729717euoutp01H
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:18:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220126091806euoutp0116f2a981f29b254fcdab94f8c7f48260~Nx2d2uPqo2971729717euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188686;
        bh=ePVbxhPw3vh6yEeAbWmTqKSPEkxLNogPAD7m75SqdNA=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=BjG96whEUroakapwqm7BkNmZz4ytxeInJyPXxneKVLsjoNxaVlSWy1xg7FCFRxFFd
         XzxsMjtVVbyNtS5sELHpIWG0J048vE23URj7gnlDlfguoh200TpEDjlfyZJHt2eElx
         1xoNVprK61O6YquUxmEKSW38X2WHBmbmtZPi0KFI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220126091805eucas1p15823b7c7b7dcfc54b43b1d031c4e2442~Nx2denVff0418604186eucas1p1p;
        Wed, 26 Jan 2022 09:18:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FF.B5.09887.DC111F16; Wed, 26
        Jan 2022 09:18:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091805eucas1p2cdcf38223dc782c63578f3d609daae96~Nx2c68JQP0205902059eucas1p2M;
        Wed, 26 Jan 2022 09:18:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220126091805eusmtrp27e4c1752b4ea74ba9824f1c99f1d63de~Nx2c59TR53163231632eusmtrp2M;
        Wed, 26 Jan 2022 09:18:05 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-d6-61f111cd59b8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0F.73.09522.CC111F16; Wed, 26
        Jan 2022 09:18:05 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091804eusmtip277f33eb8db6bbbe67ef7ab0e88bd7b9e~Nx2b73uKt2179321793eusmtip2V;
        Wed, 26 Jan 2022 09:18:04 +0000 (GMT)
Message-ID: <844bcb9b-daed-7cf6-d6f5-ff5ad2726284@samsung.com>
Date:   Wed, 26 Jan 2022 10:18:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 09/16] clk: samsung: fsd: Add cmu_mfc block clock
 information
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        sboyd@kernel.org, linux-fsd@tesla.com,
        Smitha T Murthy <smitha.t@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-10-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7djP87pnBT8mGrzbqWnxYN42Nou/k46x
        W7xf1sNoMf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaPHwVbnF51xw2ixnn9zFZnLr+mc1i
        0dYv7Bate4+wW/y7tpHF4u6ebYwWj6//YXMQ9Fgzbw2jx+9fkxg9ZjX0snlsWtXJ5nHn2h42
        j81L6j2unGhi9ejbsorR41/TXHaPz5vkAriiuGxSUnMyy1KL9O0SuDKaPu9gLTjMXHHw4T3W
        BsZm5i5GTg4JAROJE6/Xs3cxcnEICaxglNjV+pkJwvnCKNE77SkzhPOZUeJa21a4lieNp1kh
        EssZJVpfHmeEcD4ySjz7DFHFK2Ancf7mczCbRUBVYmvLJUaIuKDEyZlPWLoYOThEBZIkelqc
        QcLCAmESS5bOZwOxmQXEJW49mc8EYosI5Ev8/LeTBWQ+s8ALJolzP2eCzWQTMJToPdoHNpMT
        aNfGpptMEM3yEtvfzgE7W0LgFKdExwGYT10kth9ZwgZhC0u8Or6FHcKWkfi/cz4TREMzo0TP
        7tvsEM4ERon7xxcwQlRZS9w594sN5GxmAU2J9bv0QUwJAUeJTcvsIEw+iRtvBSFu4JOYtG06
        M0SYV6KjTQhihorE71XTmSBsKYnuJ/9ZJjAqzUIKlVlI3p+F5JtZCGsXMLKsYhRPLS3OTU8t
        NspLLdcrTswtLs1L10vOz93ECEyLp/8d/7KDcfmrj3qHGJk4GA8xSnAwK4nw/vd+nyjEm5JY
        WZValB9fVJqTWnyIUZqDRUmcNzlzQ6KQQHpiSWp2ampBahFMlomDU6qByU5R0Iz/dHrHBSFJ
        qSsZLuYPV3HuD73z/uH1cw55BZG6z++rGvC0vtqULyJfsv8h5/To1ON3q494uk7YK2LT/NWS
        mfmhWvrPoL9K3yumN7D96pyp9evmi0kZG8oWTruZmdGyeWeOxO9sD7/c6Qt2K2v3bonoCVv0
        oLrce+q8P2uvFtdYTjHY9ZFz5j7bkAL/30Jb3J5K7fsaYRq18QPz0t3FM3y2XOuTWXI9IHTJ
        p4xJL2rFrDxfCrY/b73FEiyWU1Yyz+Q834KDU+5MmFr4QvzqIzOvTs8mPZ5UiWXT0l8dUJfc
        +9JPi+vyzq3pEhO5DrFO3bf5nkxltLGXlu5m3sak3iXBi6pavwTcSPs+UYmlOCPRUIu5qDgR
        APgJjaL6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xe7pnBT8mGnx7x2jxYN42Nou/k46x
        W7xf1sNoMf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaPHwVbnF51xw2ixnn9zFZnLr+mc1i
        0dYv7Bate4+wW/y7tpHF4u6ebYwWj6//YXMQ9Fgzbw2jx+9fkxg9ZjX0snlsWtXJ5nHn2h42
        j81L6j2unGhi9ejbsorR41/TXHaPz5vkArii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DKaPu9gLTjMXHHw4T3WBsZm5i5GTg4JAROJJ42nWbsY
        uTiEBJYySvQ0PQZyOIASUhLzW5QgaoQl/lzrYoOoec8o0b/7IytIglfATuL8zedgg1gEVCW2
        tlxihIgLSpyc+YQFxBYVSJJoONbNBmILC4RJLFk6H8xmFhCXuPVkPhOILSKQL/Gn/yPYEcwC
        L5gk7p2ZArXtCKPEiqWzwLaxCRhK9B7tA9vACbR5Y9NNJpBLmQXUJdbPE4IYKi+x/e0c5gmM
        QrOQ3DELyb5ZCB2zkHQsYGRZxSiSWlqcm55bbKhXnJhbXJqXrpecn7uJEZgEth37uXkH47xX
        H/UOMTJxMB5ilOBgVhLh/e/9PlGINyWxsiq1KD++qDQntfgQoykwLCYyS4km5wPTUF5JvKGZ
        gamhiZmlgamlmbGSOK9nQUeikEB6YklqdmpqQWoRTB8TB6dUAxPvisNvmZ5urjTezlecFiqa
        Jij35Ym5QYOCq8e7D7UmS088iD3Z67nn0aqACYFNS2Wmy1RXXfTef/f+Tbl30581RvAv+hdZ
        VfpJR2+Jh1lQSfuMiIaDHSE8n3uuH3t9t0L6l6axqFgal/Uvn9yiu2sWfmy8FfY9zP/JEi9e
        v/r5OhkqPjmC03tsOUW/VpfxzKssUH/8YquAQ4eCdFKgxd419zU3zc4/xLDdJ2I705xW28kb
        69VY9296uq+g47rujycf7m3oTjq7xIbZT6J3t9DDyU0zjLii2Gev35WRwdZfWZjgvOtNavXv
        ItbiP6y2PY2vFn28rvh69aJdGy37KnO2Hf+wse114NNdubodn5RYijMSDbWYi4oTATjm8bSL
        AwAA
X-CMS-MailID: 20220126091805eucas1p2cdcf38223dc782c63578f3d609daae96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142933epcas5p4e69babee0d9ea6f94fef365d79329e20@epcas5p4.samsung.com>
        <20220124141644.71052-10-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Adds cmu_mfc clock related code, these clocks are
> required for MFC IP.
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Smitha T Murthy <smitha.t@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

