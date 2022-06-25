Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B26655A85C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiFYJEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiFYJEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:04:38 -0400
X-Greylist: delayed 905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Jun 2022 02:04:37 PDT
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C194D33E06
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:04:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656146971; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=GI/PqNgMmcvuVjYjIHPACLF7OE50Go5Gge1pQySYVs6THdL4EWr+9idFkkBJA5ygwUcT8oHYe+iWxig/gObNzagxm5eQvpuldcmr0EVdKCo8jeigb90HYO2GT2V+ddELnDWfqplHXQgn0JgmJKVHTcd9GlCFkrrDzOBrBoPy2OA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656146971; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=qFVxCH0OXTWt6AXsGk2UOTHtrXfJZLJS3HBKpZ7ryWQ=; 
        b=ZjKOmxtBySzDd5piVDcuI9//at+PbogLy7c7p3z/EoIva1h3L9wbJZxvHT7iWQmPQpGoMp75ABjWAZBIy5eqYZSoYRPwxNVmGABS5gMlzfYWRFruCpA/UfeFpe6b2fGxvOAUrGgsNh4jH7MxyoEt3w0fqQ2ApS2djntNuIyUKdQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gvisoc.com;
        spf=pass  smtp.mailfrom=gabriel@gvisoc.com;
        dmarc=pass header.from=<gabriel@gvisoc.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656146971;
        s=zoho; d=gvisoc.com; i=gabriel@gvisoc.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=qFVxCH0OXTWt6AXsGk2UOTHtrXfJZLJS3HBKpZ7ryWQ=;
        b=hXbFnaaIMtPCh4mw7WN8QmCfkqn2IZjCaAi4FVsevgg8bXVSby50KVeajLkQYmn0
        UL+9deZgsODoZ6emNcIBSnjK1MOfK9hpf6/JGEMqkq9WTwNBb28RpBhVwhq17nBUmAr
        AD2r0/WOSSYS1zd9VthTsdXVYX5h4G5LEwRJg0eI=
Received: from localhost (124-171-144-237.tpgi.com.au [124.171.144.237]) by mx.zohomail.com
        with SMTPS id 165614697055262.28503193430697; Sat, 25 Jun 2022 01:49:30 -0700 (PDT)
From:   Gabriel Viso Carrera <gabriel@gvisoc.com>
To:     andreas.noever@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: staging: Thunderbolt: ctl.c style coding issues 
Date:   Sat, 25 Jun 2022 18:49:10 +1000
Message-Id: <20220625084913.603556-1-gabriel@gvisoc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set solves all coding style issues found in ctl.c, as per
checkpatch.pl

[PATCH 1/3] staging: Thunderbolt: ctl.c: Fixed 2 literal style coding
[PATCH 2/3] staging: Thunderbolt: ctl.c: Fixed blank line coding
[PATCH 3/3] staging: Thunderbolt: ctl.c: Fixed comment coding style

