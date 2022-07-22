Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B64E57E25C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiGVNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiGVNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:33:01 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C760695C3E;
        Fri, 22 Jul 2022 06:33:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1226337B;
        Fri, 22 Jul 2022 13:33:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1226337B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1658496780; bh=Gf5V+dDS778WCgJ/togXFN0/pG3fOa3s68V7PZ2pIPw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=RO5yIM8BxfsxQCOD0hUS2p0Lsb7VUMsfoIchDID5s5uOCeDhnYf3/2HNtqzSYlcIW
         nrNZIfpDMwRNRK755WGJtpQqeB/dT/sgiMYWJ/qtoJKKn2s/uP9y9HKdo+EgChAtno
         c89hCjRi5ob0Ld+csJBqISv1AqAqgbuneXsrj+UDNkWSBVpqdwYPJZQ4N8zv4p2567
         cMSvdGcLStjB71Avu2pxt+erN616fL3+xJeqSjGP8Gy7LfS6ZgiHGEo0rMqeICeBBb
         tbWmGfewvXeywFsjYhX+OOedw1nlf20AZWlYSQktnxic/u8HFglWXL6zcuWZS/KD7t
         AIlA2H6HqrB3w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH v2 5/5] Documentation: driver-api: visconti: add a
 description of DNN driver.
In-Reply-To: <20220722082858.17880-6-yuji2.ishikawa@toshiba.co.jp>
References: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
 <20220722082858.17880-6-yuji2.ishikawa@toshiba.co.jp>
Date:   Fri, 22 Jul 2022 07:32:58 -0600
Message-ID: <87zgh1jmr9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp> writes:

No changelog?

> Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
> ---
> v1 -> v2:
>   - newly added documents
> ---
>  Documentation/driver-api/visconti/common.rst | 115 ++++++
>  Documentation/driver-api/visconti/dnn.rst    | 394 +++++++++++++++++++
>  2 files changed, 509 insertions(+)
>  create mode 100644 Documentation/driver-api/visconti/common.rst
>  create mode 100644 Documentation/driver-api/visconti/dnn.rst

Two overall comments:

 - You've added new RST files without adding them to index.rst; that
   will keep them from being part of the kernel docs build and will add
   new warnings.

 - Please avoid the use of flat-table and just use regular RST
   ascii-art tables.  Otherwise the result is nearly unreadable in the
   plain-test format.

Thanks,

jon
