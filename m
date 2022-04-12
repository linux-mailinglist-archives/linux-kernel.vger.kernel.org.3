Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5BEE4FE0AB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354280AbiDLMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354129AbiDLMiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:38:03 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED2606E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:58:20 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x200so8932144ybe.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2EUjs9gwEDMy7LHuJBroFZXQIirV6oCphrwgEBTjZVs=;
        b=pHDy3zchONQDxCSNtqCdQynLqUUyVo4f9Qa8aaXqo7K32qrdHZyeyL//EGuipGZVaI
         vx5Uj6iTQk3mrVe9kysUCbgYojMGQ6KpbNM6lhPGqNI5guGmqx3WLe+UAI/KCIM+asIA
         +rmUImgKCUN7TJIg5Dyto+1Sn/p8RjbmweUVEV6MOyKVJu/dX0QRgVCXCeUxjxrzcC9r
         zSG9fiEId/qZTWNHOJyEcs6r+NkCt7IUpZgrXRQcFYV3cujji30vZb4K98C3JMMW69iT
         NrWWxGmfTtmxnx+Eb1nUk1wf5b70kKvaw1lzdmPOxhV32K9hPoMtsG0ggam1/T4zT+3f
         RP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2EUjs9gwEDMy7LHuJBroFZXQIirV6oCphrwgEBTjZVs=;
        b=Qp524w/WDgyvk/12rDTsv729VRBaK16kQMt7t3AHz5xRQEhueksUciHBBdBqBx+xoj
         3S2FnlOUTtr5ij2tQ9+UVPBe5fExEeKBzL1XIeVE1KPNc+w6f1+0GEZ6YBGZ6FEuelTU
         gZLU36FMQ7dA0AzPlO0wqA7p+FycP1X34/qqroKc+2uk4i/r+4TK9AZT4xDg147SFo7v
         Ko7x47IPgBXfStxjnG5+3iBiciAXfRyG4dP9/jKKdir963WlyWuN9aontERNju8LJO7G
         UWixzJGZWjy1r23HUJnfkh2ZvmRh5R4GvZdWzdYjYu7EGm8LHrx7Azd3kNHcmCF1GkUR
         kY+w==
X-Gm-Message-State: AOAM531G2SA6DKTa6yQuNbgl7kL+4pYKbxYfKY/AKX6Gr2oOcscvWdOH
        2OErBgGFcfzaqK7tcEbWhjj9JcqRn4VvTIcj2Evbov1wu8DmfImU
X-Google-Smtp-Source: ABdhPJwpCofFDAgurIftVBg6F8woJY0S/ugXgXQF55+fs4vKYd5MJLcXk4WDShFm3ANHr4/M3XfgEYDUGF5b2IvlzJE=
X-Received: by 2002:a25:ae45:0:b0:641:ba5c:7745 with SMTP id
 g5-20020a25ae45000000b00641ba5c7745mr404985ybe.537.1649764699316; Tue, 12 Apr
 2022 04:58:19 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 12 Apr 2022 17:28:08 +0530
Message-ID: <CA+G9fYvXn1tgpESouPBwZgKnoeUNjM3CV1nzDWac6PjHqTskog@mail.gmail.com>
Subject: [next] ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next-20220412 arm and i386 build failed due to below errors
with kselftest merge configs.

   - build-arm-gcc-kselftest
   - build-i386-gcc-kselftest

make --silent --keep-going --jobs=8
O=/home/tuxbuild/.cache/tuxmake/builds/1/build ARCH=i386
CROSS_COMPILE=i686-linux-gnu- 'CC=sccache i686-linux-gnu-gcc'
'HOSTCC=sccache gcc'

ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:134:
modules-only.symvers] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

--
Linaro LKFT
https://lkft.linaro.org

[1] https://builds.tuxbuild.com/27gbe7oAHMk1LgDocuplOU85I62/
[2] https://builds.tuxbuild.com/27gbaEooLAS3OTMnEVMVSsbxTcZ/
