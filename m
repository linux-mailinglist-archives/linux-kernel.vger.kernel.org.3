Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE45598454
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiHRNjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244637AbiHRNjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF67757E34;
        Thu, 18 Aug 2022 06:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C28E61683;
        Thu, 18 Aug 2022 13:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AFDC433C1;
        Thu, 18 Aug 2022 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660829947;
        bh=j+GR3xNPkOEEZIReKsoLX51DZZCpOm55zjpW98JIWhQ=;
        h=From:To:Cc:Subject:Date:From;
        b=VDVU+urmE+ZEW42chc83KfdXmTEeVbpDiMmU4yB93fu+QIRGvFQfARyMVv3qM2fky
         UvGXmZB19CSQTd4YnWzzIYLRLq7kTaZLQTZcEgrjVK1jcXpxPGMbyr0j/aEMALUHmC
         8uZCuSH40n2NrqlRv8rJEuoTb7vUQnX28htCLpfE/6cxZPPobhpbl7rj3Vc/DbyQpB
         NxEdu5nr9wRACHQBh1eCme//Ovk84dqqiYsiVMqOvEpnm0ZIOXUR+B6U7CjUudGIa9
         c5Pf5QbVK59YJkgLO6FkEYBPCDH2kyTwxxxucabhBYm3UHKWtEdtHLM3PbqYCIn8it
         nDhsz5L2kppAQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.95)
        (envelope-from <mchehab@kernel.org>)
        id 1oOfjl-00AY7B-0o;
        Thu, 18 Aug 2022 15:39:05 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>, corbet@lwn.net
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>, Alex Shi <alexs@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kosuke Fujimoto <fujimotokosuke0@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Madhavan Srinivasan <maddy@in.ibm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Leach <mike.leach@linaro.org>,
        Mike Rapoport <rppt@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Rob Herring <robh@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tsugikazu Shibata <shibata@linuxfoundation.org>,
        Wu XiangCheng <bobwxc@email.cn>, Xiubo Li <xiubli@redhat.com>,
        Yanteng Si <siyanteng@loongson.cn>, coresight@lists.linaro.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-cachefs@redhat.com,
        linux-mm@kvack.org
Subject: [PATCH 00/13] Fix documentation build warnings against 6.0-rc1
Date:   Thu, 18 Aug 2022 15:38:46 +0200
Message-Id: <cover.1660829433.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

This series is against 6.0-rc1, so it should apply fine on the top of your tree.

After applying one fix sent to ACPI:

https://lore.kernel.org/linux-acpi/20220818055156.7456-1-sakari.ailus@linux.intel.com/T/#u

make htmldocs (with Sphinx 2.4.4) produces a very clean result:
:

	Warning: Documentation/devicetree/bindings/regulator/siliconmitus,sm5703
-regulator.yaml references a file that doesn't exist: Documentation/devicetree/b
indings/mfd/siliconmitus,sm5703.yaml
	  SPHINX  htmldocs --> file:///new_devel/v4l/docs/Documentation/output
	  PARSE   include/uapi/linux/dvb/ca.h
	  PARSE   include/uapi/linux/dvb/dmx.h
	  PARSE   include/uapi/linux/dvb/frontend.h
	  PARSE   include/uapi/linux/dvb/net.h
	  PARSE   include/uapi/linux/videodev2.h
	  PARSE   include/uapi/linux/media.h
	  PARSE   include/uapi/linux/cec.h
	  PARSE   include/uapi/linux/lirc.h
	Using sphinx_rtd_theme theme

The only warning is due to a driver that got its upstream way for MFD, but it seems that
the corresponding regulator driver has lost its way.

If we can fix such warning, we could add a sort of "Werror" for:

	- some ABI issues;
	- kernel-doc warnings/errors;
	- broken kernel-doc warnings.

Although there will still have Sphinx warnings that can come up from various sources,
this could help to keep documentation on a better shape, as time goes by.

Regards,
Mauro


Mauro Carvalho Chehab (13):
  scripts: kernel-doc: add support for EXPORT_SYMBOL variants
  docs: update vmemmap_dedup.rst reference
  docs: ja_JP: remove SubmittingPatches
  docs: zh_CN: remove references to rust documentation
  dt-bindings: arm: update arm,coresight-cpu-debug.yaml reference
  Documentation: coresight: fix a documentation build warning
  MAINTAINERS: fix wildcard for mfd da90* files
  MAINTAINERS: fix a typo for hpe,gxp-spifi.yaml
  ABI: sysfs-bus-nvdimm: fix a doc build warning
  docs: leds: add leds-qcom-lpg.rst to the index file
  fscache: fix kernel-doc markup on two functions
  serial: document start_rx member at struct uart_ops
  fs/dcache: fix a kernel-doc markup

 Documentation/ABI/testing/sysfs-bus-nvdimm    |   2 +
 Documentation/leds/index.rst                  |   1 +
 .../trace/coresight/coresight-cpu-debug.rst   |   2 +-
 Documentation/trace/coresight/coresight.rst   |   2 +-
 .../translations/ja_JP/SubmittingPatches      | 722 ------------------
 .../zh_CN/doc-guide/kernel-doc.rst            |   2 -
 MAINTAINERS                                   |   4 +-
 drivers/gpu/drm/scheduler/sched_main.c        |   1 +
 include/drm/gpu_scheduler.h                   |   1 +
 include/linux/dcache.h                        |  10 +-
 include/linux/fscache.h                       |   4 +-
 include/linux/serial_core.h                   |   8 +
 mm/hugetlb_vmemmap.h                          |   2 +-
 scripts/kernel-doc                            |   8 +-
 14 files changed, 33 insertions(+), 736 deletions(-)
 delete mode 100644 Documentation/translations/ja_JP/SubmittingPatches

-- 
2.37.1


