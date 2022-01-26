Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B749C620
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiAZJSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:18:41 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:63205 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238958AbiAZJSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:18:39 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220126091838euoutp029c2d63374d5a8c8bf31e85e111480c21~Nx275aqIr2277722777euoutp02k
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 09:18:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220126091838euoutp029c2d63374d5a8c8bf31e85e111480c21~Nx275aqIr2277722777euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643188718;
        bh=LPAYLyF4QsiHciH8ArQT53ok2zxlzpWAqbb9wZYwAq8=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=KNHcCMLgHQ5hBYbMhZF1shtaUChbHYwwp+ZLg+pvscOe9IQd2y3oK7jJ9sPR/iDy5
         v8mNepknet7LLs/oPEMIuKoYO5PXGZXsl99eBJhGpd6jlNTXK+4G319QBleH577DQH
         YDU1gbnBYrk26ZiGRc+Sh9umu+JKbVDgBLYU3ESc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220126091837eucas1p289744b1f18352532c357d6e57acf1fc8~Nx27aBe8U1489914899eucas1p2b;
        Wed, 26 Jan 2022 09:18:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 4F.5F.10009.DE111F16; Wed, 26
        Jan 2022 09:18:37 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220126091837eucas1p2c627c791555397d10d0dd7660d4bea0f~Nx264U_3n0148501485eucas1p2z;
        Wed, 26 Jan 2022 09:18:37 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220126091837eusmtrp20ab39d4d7d76b15505aa27ff6a1f684a~Nx263Sw_83212632126eusmtrp2A;
        Wed, 26 Jan 2022 09:18:37 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-c3-61f111ed2f76
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.A3.09522.DE111F16; Wed, 26
        Jan 2022 09:18:37 +0000 (GMT)
Received: from [106.210.134.141] (unknown [106.210.134.141]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220126091836eusmtip10ab6b391dafde68e58733d1141268b23~Nx254yeEl2412724127eusmtip17;
        Wed, 26 Jan 2022 09:18:36 +0000 (GMT)
Message-ID: <6844bdae-9823-cfc3-4acb-d547c559ae15@samsung.com>
Date:   Wed, 26 Jan 2022 10:18:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v5 10/16] clk: samsung: fsd: Add cam_csi block clock
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
        Sathyakam M <sathya@samsung.com>
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
In-Reply-To: <20220124141644.71052-11-alim.akhtar@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0wTZxjOd3e9Ht3KjsrGG2TTdO6PLYIj849L2IhOnZcgk4lB0myRQy6U
        AUV7ZQVnZkXdHKs/6BbFAkKIG9jIWMsPEYEmBGVM1mWTALFsMEEXmKV0bXVFLOM4zPjved/3
        eb73ed58FK76SxZL5ekMvF7HFahJBdF+K+SK90T5uDetlQnMxKV2knlquSVnvN+ZEVPb55Ix
        ds+/GPPNQgPGOCaHZYzP/IeM+XNmH3Ons5pkKn/pwZifRvwkU98WkDMnu/vkTKDvb8SEh+0E
        MzmyQG6JYq9euorYJ/MWxFpNp0nWYfuSZMeGu0i25fJRdujHMhl7ptWG2HBZjZz1O15JU2gU
        b+fwBXmf8PpNyVkKbXlVE3mwFS+xzD3ETCiElaMICujNYBp4uoxVdCOCQFNWOVIs4QCChmAL
        kgo/gqY5v/yZYsLRiEmDBgSu/sGVwofgxHQZIbKUdDI4z3bhIibo1yC40COX+lEwcHFqiUNR
        L9LZYD6xTWyvoTOg026WiRinY+DuVO2ypWi6CELh64T4Pk7fw8Bq8pPigKQT4fTNM0jEEUu7
        7HcfyiXxOrjmqcZFAdC/RUBNqI6QbG8Ht7tKJuE1MNPfuhInDhav12KS4DgC8w23XCrOIRjv
        r0MSKwnGXPOkaBunX4fmzk1Seyt4Zm8spwE6EkY9UZKJSLC0X8ClthJOfa6S2Bvgie3Cyt1j
        4aupReIcUltXncW6Kr91VRzr/3vrEGFDMXyxUJjLC4k63pggcIVCsS434UBRoQMt/cXb4f5/
        OlDNjC+hF2EU6kVA4epo5WKKl1Mpc7jSw7y+aL++uIAXetFailDHKA/k/cCp6FzOwOfz/EFe
        /2yKURGxJiw+Y276BXdQ22x4d36u6/H9tOnuQ8pq58fdg/nJfHpbT2TSLEFuVLwXrlif/c7X
        w9npPZqbez41ZplSS5/nTnYMYtuPx1+LDl/5uaEi53DqUMyjXCGxbcKZ/sg3gK70udxFY4b1
        dOnt2Q/dR9ZtO2+9P440ZsF+r8S4MHq+w7vXsk/XZbK73081GI/tdRrsmUdyHmhPhS57vw06
        H4fqP/tgy6TSUFLl2MVmpAR2VGqi635XZRbsya+A7zMHx4+Gz77kDO4s/HU+Sa/p3XHM+LIZ
        Fi9aRndu2FW//zk2bXrE1J2ENa1N1X5x6K3G8KstzUN3bLs/Mmwt9T7YuDklTuiIUxOClkt8
        A9cL3H94nq1C+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsVy+t/xu7pvBT8mGtz7w2nxYN42Nou/k46x
        W7xf1sNoMf/IOVaLjW9/MFlM+bOcyWLT42usFh977rFaPHwVbnF51xw2ixnn9zFZnLr+mc1i
        0dYv7Bate4+wW3w58prR4t+1jSwWj6//YXMQ9Fgzbw2jx+9fkxg9ZjX0snlsWtXJ5nHn2h42
        j81L6j2unGhi9ejbsorR41/TXHaPz5vkArii9GyK8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1
        DI3NY62MTJX07WxSUnMyy1KL9O0S9DK6Zq9lK9jCXDHpwxumBsafTF2MnBwSAiYSDzatALK5
        OIQEljJKXJ79n7mLkQMoISUxv0UJokZY4s+1LjaImveMEk1HVoE18wrYSezv38MMYrMIqEp8
        /bOPHSIuKHFy5hMWEFtUIEmi4Vg3G4gtLBAmsWtjDyuIzSwgLnHryXywOSIC+RJ/+j+ygixg
        FnjEJDH/yzt2iG1HGCVuPJsMNolNwFCi92gfI4jNCbR546037CCXMguoS6yfJwQxVF5i+9s5
        zBMYhWYhuWMWkn2zEDpmIelYwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzAJbDv2c/MO
        xnmvPuodYmTiYDzEKMHBrCTC+9/7faIQb0piZVVqUX58UWlOavEhRlNgWExklhJNzgemobyS
        eEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqblwYErxMMWX2Xm3O64
        S+tDHfeL2uPHfimJdmc/EXfiKp1npH76VQbflHJ2r382hz/VfN4pe+VZh8/X/qQP6v//1zMs
        fxLA4//wy5vOh8u2H/+ZMe/dFYapZWEi04qn1a1nLjpUuG77M6/bE3WXnotbtPkPw/tF3seP
        FIUbat9X3Xzjff7EFcKG/7TP8X5/w7qhbf1mHhPVn2zrevmOu+82uFR7isehLYb5QHXdw7nM
        YaJyu8PLchkOVDnLOa/XYtc//WSHW22Jj97xUk4Fhyy/7Xfua8+oXall/UDtUXbuDp05UgsP
        fGvZdnd27m2zCP/4/xFT3sxxPTnF+MG6NwHzJm+LrNbR71MIl2UyOsilxFKckWioxVxUnAgA
        pgUAtYsDAAA=
X-CMS-MailID: 20220126091837eucas1p2c627c791555397d10d0dd7660d4bea0f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124142937epcas5p3bdce50bbaa02bbd762cf000401e03ade@epcas5p3.samsung.com>
        <20220124141644.71052-11-alim.akhtar@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.01.2022 15:16, Alim Akhtar wrote:
> Adds clocks for BLK_CAM_CSI block, this is needed for CSI to work.
> 
> Cc: linux-fsd@tesla.com
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Signed-off-by: Sathyakam M <sathya@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
