Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA50D4CBD5C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiCCML3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbiCCML2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:11:28 -0500
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C351148654
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 04:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1646309436;
        bh=//ymGdk7HNhQ+1FLdApELNcWg1XftHb+6/AN8y3a2P4=;
        h=Date:From:To:Cc:Subject:References;
        b=URnwJ2L6Ou6Zs9aNV/Rmvt7K6MXwti2jQLf+OaxwpPPDD1VzvSuYertJhWc+5M/wB
         DBM/xfR/d3vvpZ6jDzm61ZXsZH8swcY6H42nVtHuIvO2Hr+oIScJDmnErjhRgqnUdv
         +UJAogWI57rNXyHfb/1cJuK5L3af+vwnE6raezq0=
Received: from LAPTOP-4BSPBRI7 ([59.172.176.225])
        by newxmesmtplogicsvrsza5.qq.com (NewEsmtp) with SMTP
        id 2A2068B8; Thu, 03 Mar 2022 20:10:34 +0800
X-QQ-mid: xmsmtpt1646309434tyxmq411j
Message-ID: <tencent_BB227799838E82307C4669F17F17449E3905@qq.com>
X-QQ-XMAILINFO: MAehWEgsdgwGaAkBXW7HaopTW6gLQHO6tn3SSTyPJFpSsYRu3bSzZWOVa/gqpF
         xkc9Q0NLb+KraiDXaUjXiXM0AwPW/L5wneCxJl4EIKIiRdYEMqiZysLrt+Km9fL+CQtCdWO8wTMu
         xz+yLg09LiWbDI3blQEuDvJNGYGx2AzhRAkAQsqfppUCzNd3Z6+vk+RDz0RDZV756ypg6cXqgT0/
         oOMrcoZJuI7FptrROs8+E6opmtcG0IVu8kbHVV9+twcX/h9XP+jXsI9JxpX1LtIsF/REmZvcyd4W
         mfj7lcq7ZdHADUYSZVjxGM9/J0T83pPdzKqoXDv/y0XDplcjep0MeDVcJ4dcTLlaeGm4GNOF/382
         SQUuEAWiYzmDqdyiFmL0UrGm6SwbyaQ3g2jDlh8/V7Ve/mdYP7fMfYq3urCrJGaK7UY71yrPYlZp
         dvOzpBpnsFfULboho4Wqm+2iDDPKbKzA6FifIhbkH1pIWw5iAE1WDeC+WsFi+xgZqIEWnnY2h0E3
         RcE7Ddhh9+mchdBpf2V1QoSRadWpx4PJmELaIa2lOrrHmOQED4/+wVkcM4RJkKrL6TiODLFvRCPf
         DUWaH/f35rgpcVnS8tA7oz5wp4jpmqeZHF+ezHpC+y5GirDpfGH2lc4Objd/zqrvkfUX4ggjL4J9
         h7goRitHH+ykZ69EGI68+BBhQX5OQ6GNoJGhdLRVmnrdDJ41i5tpwPeFJLZuxMWNPWuqyqXSpqQF
         cTF65RPz9D6eTo6L1WBe5mscrgrrEA6jT6R99kbptUE21AqXMSM+Xo6zCKrfumTouFG8v4HRG7pY
         aCYu7AMWYjJeje+Tau+LKD5+9p+nTufFegaKLhhR0X9iVuwBlMqDUGBIahR4Qa9W9LkkQBo2gBYD
         S43EfYtN9eF6J5qbtgJM1YX/eHuON/yoxhlfgbHoKxmrG6SXDL72yiXMrWB8iK7KvzEKbsv6Nw6n
         ku370hmxMMlrL7v9YyriEyux8PkmAK3PylxDsHk4H9CCDLm7ssZw==
Date:   Thu, 3 Mar 2022 20:10:34 +0800
From:   "Xiaoke Wang" <xkernel.wang@foxmail.com>
To:     "Matthew Auld" <matthew.william.auld@gmail.com>
Cc:     Airlie <airlied@linux.ie>, daniel <daniel@ffwll.ch>,
        Development <intel-gfx@lists.freedesktop.org>,
        list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/selftests: check the return value of kstrdup()
References: <tencent_7E4716854F78B812C4FF16C83573486E1806@qq.com>, 
        <CAM0jSHO=yudjZeWbVCwdVnaJ1kJ7k34unQVvyCBxTji=u3WnWQ@mail.gmail.com>, 
        <CAM0jSHMkSNuyjEKGtDBdmpLcQS8-r_ZevR0d2iVTGEVvUmKV3g@mail.gmail.com>
X-Priority: 3
X-GUID: C1928F08-1A37-4B2A-A9E3-7A5763F40478
X-Has-Attach: no
X-Mailer: Foxmail 7.2.23.116[cn]
Mime-Version: 1.0
X-OQ-MSGID: <2022030320103355373135@foxmail.com>
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWF0dGhldyBBdWxkPG1hdHRoZXcud2lsbGlhbS5hdWxkQGdtYWlsLmNvbT4gd3JvdGU6Cj4gU2Ny
YXRjaCB0aGF0LiBpdCBsb29rcyBsaWtlIHRoZSBmb3IoKSBhbHJlYWR5IGFjY291bnRzIGZvciB0
aGlzLCBhcwo+IHBvaW50ZWQgb3V0IGJ5IENocmlzLgoKWWVzLCB5b3UgYXJlIHJpZ2h0LiAKSSBy
ZWNoZWNrZWQgYW5kIGZvdW5kIHRoaXMgb25lIGlzIGluZGVlZCBhbiBvcmRpbmFyeSBjb2RlIHNt
ZWxsLgpUaGFuayB5b3UgZm9yIHRha2luZyB0aGUgdGltZS4KCgpYaWFva2UgV2FuZw==

