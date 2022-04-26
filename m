Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25746510238
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352618AbiDZPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiDZPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:54:45 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF23F31A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:51:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t13so4693594pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v8cU5bKFMqlUuUtYVrwHpXixHreHsdDZ5/tA68unRFg=;
        b=z9jNRQOpE/Sy4KaGPIjyQ63hGbkDuUOcXGtvu36rlAtQoDqkL19FzzRktCC2+lj5qa
         C7zd+6sVPjS6moGVds0Lad0bqu8BkMudsmN8g69TWBSHcMKHplQC9iSNgNkEgj68TuxD
         Tuavedz3GccOYKxUiE3cGhs9AZFLHaqjcW2FvpmK0T/qaHKuxgqw0U95zdf4n+sphSz9
         0b2yDXdlm0G92GZcQnLPlkKDk+jvOP1v3KDJHUwhA//rPV/9A9XQk0f/XRmbHDQ8PgeT
         0quZywvXJ6nke6mC5W4YHL/IUuOGoIP/nCDplAiQZMKzbAgUighl8w8jrzogCpwEUHvf
         YmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v8cU5bKFMqlUuUtYVrwHpXixHreHsdDZ5/tA68unRFg=;
        b=28fTbdpAyk2nwCX7cVK7S9p4EMM9H+ehnhrTOPXCbWQlysEc+VL9WgAhk4SA1EuLkx
         FZOJlhjBa2opiHfhNR2vKVUS+x/DysmnHc6VMpTL0uV/kKrsI70Gw58OP93XBMmfqsP0
         h+RKc8xNb8raTBZqKHPFi9rwqz6nQmrD4PTGi+ltxy2Y5ORZxRfQtcbJfPu6jQoJ81Dm
         8KZeN20apTWx/RlJRb3a/PmUJxH/dK43yxVsbn7we2/MghSniIgSl646DTp/9aiK6TOx
         0aUvkR5eK80xsITfKfLhX2cl9Ae6JZ5mlpndsE9oiJJ4irzULLObX3GT0aVeu3VXkGt6
         4nvw==
X-Gm-Message-State: AOAM532T0tpRvmK0LKm4fpaWKGeZl6YLXVdmUd++YJJCycKEeAQLMq87
        8uReCmsyIfsj78onDHSlAuEVKUlKLML9cb8/cvzoVQ==
X-Google-Smtp-Source: ABdhPJyfaEQLDnkVKgh0MtbEZ4gvbRl+qUICHAWbhcZ3BgAHnuv4WbhYJEEIYUxjL70Qul6l8H8GJjGjD1eBVqdRwAE=
X-Received: by 2002:a05:6a02:283:b0:342:703e:1434 with SMTP id
 bk3-20020a056a02028300b00342703e1434mr20047391pgb.74.1650988297199; Tue, 26
 Apr 2022 08:51:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220426123839.GF163591@kunlun.suse.cz>
In-Reply-To: <20220426123839.GF163591@kunlun.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 26 Apr 2022 08:51:25 -0700
Message-ID: <CAPcyv4j66HAE_x-eAHQR71pNyR0mk5b463S6OfeokLzZHq5ezw@mail.gmail.com>
Subject: Re: ndctl tests usable?
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 5:39 AM Michal Such=C3=A1nek <msuchanek@suse.de> wr=
ote:
>
> Hello,
>
> there is some testsuite included with ndctl, and when following the
> instructions to build it most tests fail or are skipped:
>
> [   95s] Ok:                 3
> [   95s] Expected Fail:      0
> [   95s] Fail:               5
> [   95s] Unexpected Pass:    0
> [   95s] Skipped:            15
> [   95s] Timeout:            0
>
> Is this the expected outcome or is this a problem with the ndctl build?
>
> Attaching test run log.

I see a few missing prerequisites:

[   78s] /usr/src/packages/BUILD/ndctl-73/test/pmem-errors.sh: line
64: mkfs.ext4: command not found
[   95s] /usr/src/packages/BUILD/ndctl-73/test/security.sh: line 25:
jq: command not found

This report:

[   51s]  1/23 ndctl:ndctl / libndctl               SKIP
0.02s   exit status 77

...seems to indicate that the nfit_test modules did not appear to load
correctly. I never expected that the nfit_test modules would be
redistributable, so I was surprised to see them being installed by an
actual package "nfit_test-kmp-default-0_k5.17.4_1-6.1". The reason
they are not redistributable is because they require replacing the
production build of the kernel provided modules libnvdimm.ko,
nd_pmem.ko, etc... What I expect is happening is that the production
version of libnvdimm.ko is already loaded (or is the only one on the
system), and ndctl_test_init()
(https://github.com/pmem/ndctl/blob/main/test/core.c#L110) detects
that case and skips the tests.

This is what I see with my setup that uses the sequence below to
install nfit_test and friends:

Test summary:
Ok:                 35
Expected Fail:      0
Fail:               1
Unexpected Pass:    0
Skipped:            1
Timeout:            0

Install procedure from a kernel build directory:
        export INSTALL_MOD_PATH=3D$root
        make INSTALL_HDR_PATH=3D$root/usr headers_install
        make M=3Dtools/testing/nvdimm modules_install
        make M=3Dtools/testing/cxl modules_install
        make modules_install
