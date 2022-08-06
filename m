Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C3358B541
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiHFLmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiHFLmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:42:47 -0400
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 06 Aug 2022 04:42:46 PDT
Received: from mailgate.osadl.org (mailgate.osadl.org [62.245.132.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63013E14
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 04:42:46 -0700 (PDT)
Received: from localmail.osadl.org (localmail.osadl.org [192.168.115.248])
        by mailgate.osadl.org (Postfix) with ESMTP id A16583004AF;
        Sat,  6 Aug 2022 13:33:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=osadl.org; s=default;
        t=1659785617; bh=13NoCHxS6P/Vc0vRA1az1nnlXTxakQXd/y25xEgabsk=;
        h=Date:From:To:Cc:Subject:From;
        b=WNwO/6hY7iMr9KKta3uKMVIN4hqy7Y3QyYsUe9g/4K32I+E4+uV1ADr1TnmysmN7q
         M2OVqyc0FLQYQ53qxKF5g58F603OAP9CaF1fk7Dawtq1tHeK8Rf4We2JhgV8J3Zi6s
         w4Q2qksxadeW+QiV2zTOxqxUQK0ReRDdMqfMcsNI=
Received: from localhost (localhost [127.0.0.1])
        by localmail.osadl.org (Postfix) with ESMTP id 6F8C39E9AF2;
        Sat,  6 Aug 2022 13:33:34 +0200 (CEST)
Received: from localmail.osadl.org ([127.0.0.1])
        by localhost (localmail.osadl.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id F9JvpeAve5Ri; Sat,  6 Aug 2022 13:33:33 +0200 (CEST)
Received: from rack0slot6s.osadl.org (rack0slot6s.osadl.org [192.168.114.6])
        by localmail.osadl.org (Postfix) with ESMTP id 341538BBBF5;
        Sat,  6 Aug 2022 13:33:33 +0200 (CEST)
Received: from rack0slot6s.osadl.org (localhost [127.0.0.1])
        by rack0slot6s.osadl.org (8.17.1/8.15.2) with ESMTP id 276BXYkf4095518;
        Sat, 6 Aug 2022 13:33:34 +0200
Received: (from root@localhost)
        by rack0slot6s.osadl.org (8.17.1/8.17.1/Submit) id 276BXYU54095517;
        Sat, 6 Aug 2022 13:33:34 +0200
Message-ID: <20220806113124.608017725@osadl.org>
User-Agent: quilt/0.66
Date:   Sat, 06 Aug 2022 13:31:24 +0200
From:   Alexander Baehr <abaehr@osadl.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add support for parallel port devices Netmos 9900 and Asix 99100
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Virus-Scanned: clamav-milter 0.103.6 at mailgate
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for the established parallel port devices Netmos 9900 and Asix 99100 
was lacking. This patch queue adds support for them and was successfullly 
tested on the two devices.

Signed-off-by: Alexander Baehr <abaehr@osadl.org>  

