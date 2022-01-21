Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D8D495BED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379295AbiAUIan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:30:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:49682 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349535AbiAUIam (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:30:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642753842; x=1674289842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mx3znovqbTqSHRCLPhWAXVsdrHy1wURwplgEYl4lCrs=;
  b=dqf8bvX/mu8LAU+agxPKiHdEI+LJPDgXYJsd9yUQRmleydCLs6T8Xwbx
   R7b4ORW/gGwBomYUqgPeF03USoYKD3lZrCAGj7CnymePj4Wxlaslbctp0
   JSzT16XDtMHlyIx2tR+V+fYFBRqPf9Qx7NYA0ZjNwYMcQHuYgurETLGpk
   9H01hPnJbrrDXjkiyxcfggRe3YN5M9Us9FLKSkHsGDxzWIZbj/bBNkzaP
   +aq5Zard118Vtk0SDASf803UF0WO68obuSxxy+ZvBMIw3GuVOSBqLMLnB
   iZ6LjFc/DVxLXH1VePpo91tmpjzEDMnss+KjnUEoToNz0glAfLmKmadHD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="244419821"
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="244419821"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 00:30:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,304,1635231600"; 
   d="scan'208";a="518982996"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2022 00:30:39 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nApJe-000F73-N2; Fri, 21 Jan 2022 08:30:38 +0000
Date:   Fri, 21 Jan 2022 16:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhenwei pi <pizhenwei@bytedance.com>, mst@redhat.com,
        arei.gonglei@huawei.com
Cc:     kbuild-all@lists.01.org, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        helei.sig11@bytedance.com, zhenwei pi <pizhenwei@bytedance.com>
Subject: [RFC PATCH] virtio-crypto: virtio_crypto_rsa_do_req() can be static
Message-ID: <20220121082951.GA46247@b53fa9759326>
References: <20220121022438.1042547-4-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121022438.1042547-4-pizhenwei@bytedance.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/crypto/virtio/virtio_crypto_akcipher_algo.c:276:5: warning: symbol 'virtio_crypto_rsa_do_req' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 virtio_crypto_akcipher_algo.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
index eebccf71b2fab..2b3f8780b7551 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algo.c
@@ -273,7 +273,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	return -ENOMEM;
 }
 
-int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
+static int virtio_crypto_rsa_do_req(struct crypto_engine *engine, void *vreq)
 {
 	struct akcipher_request *req = container_of(vreq, struct akcipher_request, base);
 	struct virtio_crypto_akcipher_request *vc_akcipher_req = akcipher_request_ctx(req);
