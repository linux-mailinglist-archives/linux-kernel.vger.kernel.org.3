Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D7D4F142C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbiDDMA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiDDMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:00:25 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AF4B73;
        Mon,  4 Apr 2022 04:58:28 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id kw18so2299024pjb.5;
        Mon, 04 Apr 2022 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=Ryz34qEMQ5WdkUF9th9E6KFUWpiEza21IKgfS/GNkQE=;
        b=JSIdWcPZQ+LozQNtd4kT3V98R6r+cz6WCggkYyRRSVOnlnjUMoTJwc1s+IGN0NYHXC
         GO0GSmfjSOBgafLwp7qSrTk3HdJapXbgDHCdO7IVt/nqCYxlP7adq0wv1CpVnvznnZXQ
         yzjuERvFKvSjCZRMaM2e2JESz+aeVDHkwmyyNU7r4HMckXgsqQdLpSMCpPr+rYWnirYf
         0ryYVr4okzz19UhDiCBt+aJxZB9/S6O6D8Y6fmlWmHoiwYbdRjWt9lKXEkS8W9rg7RTo
         7v1aRCZTtQsNq2xoRSBcwX6j9NhkIh1svKNHdgyReqaVpcYtAxZfUq9ym1PfVqUSCW0P
         QV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=Ryz34qEMQ5WdkUF9th9E6KFUWpiEza21IKgfS/GNkQE=;
        b=X09Mpefbv1ZaRKYEJw5Ss1UrS/6+RfWE1mneG5HFSlcG/9JkiTTB7PUo8m+3GOSJ48
         2Cby3ZdVRrE6L49xYTUccLQBnuDs6JvibTeiiHzecHRnYPyDKQWy0gAQSkP6MNcsrBcV
         apVXNsDhAnP4HHqZZms56d4YGXe73W5A9BhqL3m7XyV9MdSeaAYFn8QvF5u5yz4z0HfY
         Lu2ORrMTNNZtsXoHD2X3Rzmhg44crRLh+X3qEduH1GtdQWmTQNsFn2jnkGsg4P3kZJQX
         8g2BWjplKeiiD7Rl0nIiI1NAwTinvcXxbTY9wslMgAD+YlDm6lqZlfZwRIfe0ejfpyp+
         eUiQ==
X-Gm-Message-State: AOAM531zBvXb5QTyMQ+DVTxrkfuFjt/5tVJSIXa6OvuitjGECJfsbnf+
        K/HaEP/fbgPaB54dCg6+Hagkdf463b2qXfHR
X-Google-Smtp-Source: ABdhPJxpbrLNB8v/iWD/bPLPFGjZ59ZyPHfn79PXsZ4wc0t5WF8z3pTGefWr97MmLVEidel4StveYQ==
X-Received: by 2002:a17:90b:250f:b0:1ca:b9fa:efcd with SMTP id ns15-20020a17090b250f00b001cab9faefcdmr730685pjb.123.1649073507672;
        Mon, 04 Apr 2022 04:58:27 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-68.three.co.id. [180.214.233.68])
        by smtp.gmail.com with ESMTPSA id h12-20020a056a00230c00b004faf2563bcasm12588934pfh.114.2022.04.04.04.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 04:58:26 -0700 (PDT)
Message-ID: <564f87a9-dd57-d3a1-d476-d81350baf75d@gmail.com>
Date:   Mon, 4 Apr 2022 18:58:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-doc@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com,
        linux-iio@vger.kernel.org
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: unexpected indentation warning in Documentation/ABI/testing/sysfs-*
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Huang Jianan <huangjianan@oppo.com>, Chao Yu <chao@kernel.org>,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mark Pearson <markpearson@lenovo.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        "David E. Box" <david.e.box@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Doing "make htmldocs" for Linux v5.18-rc1, I get new warnings:

<path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Block quote ends without a blank line; unexpected unindent.
<path/to/linux>/Documentation/ABI/testing/sysfs-driver-intel_sdsi:2: WARNING: Definition list ends without a blank line; unexpected unindent.
<path/to/linux>/Documentation/ABI/testing/sysfs-bus-nvdimm:11: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-bus-iio-sx9324:2: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-class-firmware-attributes:130: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-fs-erofs:10: WARNING: Unexpected indentation.
<path/to/linux>/Documentation/ABI/testing/sysfs-fs-erofs:10: WARNING: Block quote ends without a blank line; unexpected unindent.

Introduced by 2546c60004309e (platform/x86: Add Intel Software Defined
Silicon driver, 2022-02-11), 2bec6d9aa89cbe (docs: ABI: sysfs-bus-nvdimm:
Document sysfs event format entries for nvdimm pmu, 2022-02-25),
e8a60aa7404bfe (platform/x86: Introduce support for Systems Management
Driver over WMI for Dell Systems), 40452ffca3c1a0 (erofs: add sysfs
node to control sync decompression strategy, 2021-12-06), and
4c18a890dff8d9 (iio:proximity:sx9324: Add SX9324 support, 2022-01-01).

Presumably because Sphinx mistakes these documentation files without
extensions for .rst files? I dunno.

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
