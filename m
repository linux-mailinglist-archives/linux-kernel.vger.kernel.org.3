Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364F756657E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiGEIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGEIyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:54:04 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E149116B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:54:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31c8bb90d09so48113927b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1BeUYAOT9aJhDCdSPlyhNbR9ZdxEmIdIn84wq6pOEc=;
        b=iJhMZGI3QmJgu/F7x5eDwlpbmXNoZFQjJ9c+ytOLPOrVCVUC/sobisyfFHauVbdfi2
         m7vbiSUl1LNgb9mS4eGB3nemAmm8bQqG8vlIk7sYG0u0pPYBybm9OHL2DjRArAqxKCIB
         qF6u6BbZR+DS8DBS5fHjFA4DWTB8Ewqufch1Oz8g4H9SVscnQLaoPa/3iXrZ/7vqS4hw
         QcCziqwXQ0ejk/SNAe0mUobBemZjJuTuyC8mgziQw1EXg96lVT/VqqGhGeCQaxbezuko
         ZJqmLmkjdACzo3QpZX6HoC5NmVkNwjhCk/CWzI9UfhfzR7ty/LVlqvjU3fXzJn+HJn8M
         c90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1BeUYAOT9aJhDCdSPlyhNbR9ZdxEmIdIn84wq6pOEc=;
        b=PZq3gEKFAg4cfLew9xFInI5N+ae9Umkx+k9+Rtk0IpAt/ESKvmXdvcGC56gxY7fVCF
         jZPmf0dscSmNQkMegGpQ30m2By6k+zREc2xymu5+Mq2VTBHAPDu92NRpa425vdX5M5If
         F3HUhQyJxS6EqilyARoaEUwrpgY1Hf9jkSLBl0N6SZdYggp7/Bl2iBywyCWrIJNGJD/B
         PJGltb7snglfOa7yB9CRYCz2MsrVffDZ4MF9aV4fL1yDyNvQjY/cP+q6qwcXAiw9hjbh
         DNSnGfgEOZHY4tr2lJXZhseX+6skAr1cOpBJWOG5OKO/ylFkSCt8vW9z3S3HRqAEx2J9
         JTNw==
X-Gm-Message-State: AJIora/OmnlL9RR68GK0T9e0XdXzk2V+6NXCLuAzDQpiD4EWC9vqdRI8
        8wGMDjqRYLdLIY3beTXq382di3wdomuESxibeuBb4w==
X-Google-Smtp-Source: AGRyM1vSZTebgdYTffrKYPD7AxJ2wLktKw76RMBfHVMAxyoZ5wxWMP3QSFRTsvxqnbhJZIQ0pH4hbnbO5d+I6P4YGUM=
X-Received: by 2002:a81:1586:0:b0:31c:80cd:a035 with SMTP id
 128-20020a811586000000b0031c80cda035mr18186499ywv.332.1657011242528; Tue, 05
 Jul 2022 01:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <8cadab244a67bac6b69324de9264f4db61680896.1657001998.git.mqaio@linux.alibaba.com>
 <cover.1657001998.git.mqaio@linux.alibaba.com> <0146c84b4161172e7a3d407a940593aa723496ea.1657001998.git.mqaio@linux.alibaba.com>
 <7723937608e9f23b2a904615ae447beaf9f28586.1657001998.git.mqaio@linux.alibaba.com>
In-Reply-To: <7723937608e9f23b2a904615ae447beaf9f28586.1657001998.git.mqaio@linux.alibaba.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 5 Jul 2022 10:53:51 +0200
Message-ID: <CANn89iLbgxZSQezYUmQhb8=+OfHDMkEVv=+5hQ4irhw8WaqsSQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: hinic: fix bug that u64_stats_sync
 is not initialized
To:     Qiao Ma <mqaio@linux.alibaba.com>
Cc:     David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, gustavoars@kernel.org,
        cai.huoqing@linux.dev, Aviad Krawczyk <aviad.krawczyk@huawei.com>,
        zhaochen6@huawei.com, netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 8:26 AM Qiao Ma <mqaio@linux.alibaba.com> wrote:
>
> In get_drv_queue_stats(), the local variable {txq|rxq}_stats
> should be initialized first before calling into
> hinic_{rxq|txq}_get_stats(), this patch fixes it.
>
> Fixes: edd384f682cc ("net-next/hinic: Add ethtool and stats")
> Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
> ---
>  drivers/net/ethernet/huawei/hinic/hinic_ethtool.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> index 93192f58ac88..75e9711bd2ba 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_ethtool.c
> @@ -1371,6 +1371,9 @@ static void get_drv_queue_stats(struct hinic_dev *nic_dev, u64 *data)
>         u16 i = 0, j = 0, qid = 0;
>         char *p;
>
> +       u64_stats_init(&txq_stats.syncp);
> +       u64_stats_init(&rxq_stats.syncp);
> +

This is wrong really.

txq_stats and rxq_stats are local variables in get_drv_queue_stats()

It makes little sense to use u64_stats infra on them, because they are
not visible to other cpus/threads in the host.

Please remove this confusion, instead of consolidating it.

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_main.c
b/drivers/net/ethernet/huawei/hinic/hinic_main.c
index 56a89793f47d4209b9e0dc3a122801d476e61381..edaac5a33458d51a3fb3e75c5fbe5bec8385f688
100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_main.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_main.c
@@ -85,8 +85,6 @@ static void update_rx_stats(struct hinic_dev
*nic_dev, struct hinic_rxq *rxq)
        struct hinic_rxq_stats *nic_rx_stats = &nic_dev->rx_stats;
        struct hinic_rxq_stats rx_stats;

-       u64_stats_init(&rx_stats.syncp);
-
        hinic_rxq_get_stats(rxq, &rx_stats);

        u64_stats_update_begin(&nic_rx_stats->syncp);
@@ -105,8 +103,6 @@ static void update_tx_stats(struct hinic_dev
*nic_dev, struct hinic_txq *txq)
        struct hinic_txq_stats *nic_tx_stats = &nic_dev->tx_stats;
        struct hinic_txq_stats tx_stats;

-       u64_stats_init(&tx_stats.syncp);
-
        hinic_txq_get_stats(txq, &tx_stats);

        u64_stats_update_begin(&nic_tx_stats->syncp);
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
index 24b7b819dbfbad1d64116ef54058ee4887d7a056..4edf4c52787051aebc512094741bda30de27e2f0
100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_rx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_rx.c
@@ -66,14 +66,13 @@ void hinic_rxq_clean_stats(struct hinic_rxq *rxq)
 /**
  * hinic_rxq_get_stats - get statistics of Rx Queue
  * @rxq: Logical Rx Queue
- * @stats: return updated stats here
+ * @stats: return updated stats here (private to caller)
  **/
 void hinic_rxq_get_stats(struct hinic_rxq *rxq, struct hinic_rxq_stats *stats)
 {
-       struct hinic_rxq_stats *rxq_stats = &rxq->rxq_stats;
+       const struct hinic_rxq_stats *rxq_stats = &rxq->rxq_stats;
        unsigned int start;

-       u64_stats_update_begin(&stats->syncp);
        do {
                start = u64_stats_fetch_begin(&rxq_stats->syncp);
                stats->pkts = rxq_stats->pkts;
@@ -83,7 +82,6 @@ void hinic_rxq_get_stats(struct hinic_rxq *rxq,
struct hinic_rxq_stats *stats)
                stats->csum_errors = rxq_stats->csum_errors;
                stats->other_errors = rxq_stats->other_errors;
        } while (u64_stats_fetch_retry(&rxq_stats->syncp, start));
-       u64_stats_update_end(&stats->syncp);
 }

 /**
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
index 87408e7bb8097de6fced7f0f2d170179b3fe93a9..2d97add1107f08f088b68a823767a92cbc6bbbdf
100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_tx.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_tx.c
@@ -91,14 +91,13 @@ void hinic_txq_clean_stats(struct hinic_txq *txq)
 /**
  * hinic_txq_get_stats - get statistics of Tx Queue
  * @txq: Logical Tx Queue
- * @stats: return updated stats here
+ * @stats: return updated stats here (private to caller)
  **/
 void hinic_txq_get_stats(struct hinic_txq *txq, struct hinic_txq_stats *stats)
 {
-       struct hinic_txq_stats *txq_stats = &txq->txq_stats;
+       const struct hinic_txq_stats *txq_stats = &txq->txq_stats;
        unsigned int start;

-       u64_stats_update_begin(&stats->syncp);
        do {
                start = u64_stats_fetch_begin(&txq_stats->syncp);
                stats->pkts    = txq_stats->pkts;
@@ -108,7 +107,6 @@ void hinic_txq_get_stats(struct hinic_txq *txq,
struct hinic_txq_stats *stats)
                stats->tx_dropped = txq_stats->tx_dropped;
                stats->big_frags_pkts = txq_stats->big_frags_pkts;
        } while (u64_stats_fetch_retry(&txq_stats->syncp, start));
-       u64_stats_update_end(&stats->syncp);
 }

 /**
