Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B922853C082
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 23:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239510AbiFBVyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 17:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239500AbiFBVx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 17:53:57 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF0210559
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 14:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654206834; x=1685742834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+APPp6+GdQ8qvUxCgR5B+0LRWWWLrtrPS8G0XKloSrQ=;
  b=NEyZDQPtU2Nzhkyv7RHecsaFpsuLbS6XDKm4O4s/8FFjesyaGZUJ0cI+
   wezoRDDA+POTO/SullcwdYT0VQ+BzDqp42wi4G2BDJ9WV+1IOfE2wiAZR
   sRWy+YR8bDBCfqpQKsQvCEIuJCzuUN8/En6sflmiFCT9CY3euPjRsw7AS
   jhSOUV47HjSsFYKpQWJdT0cSm6WHqmP1tV7b5Y5AvVWUHWR2ppXpq65VQ
   9orCzkR4mMwj0dxZCoChrfQxXNVTyY7kqAud2IubQA1PMQVTIzoZHK+TG
   QvdgOhPvEWUk1xiVi+s2GZTDea9/M0ykUUlmatR7W7oR5ULaUhF+1MBqs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="301459921"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="301459921"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 14:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="721494084"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jun 2022 14:53:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwslL-0005TN-PZ;
        Thu, 02 Jun 2022 21:53:51 +0000
Date:   Fri, 3 Jun 2022 05:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [agd5f:drm-next 33/63]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:57:
 warning: implicit conversion from 'enum scan_direction_class' to 'enum
 dm_rotation_angle'
Message-ID: <202206030552.odeXyIQd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   0401cdad37f8a62e64363b2a6fc16c7fafba66e2
commit: 5cbb369e32bd21b10ff374f87369838788c601e5 [33/63] drm/amd/display: DML changes for DCN32/321
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220603/202206030552.odeXyIQd-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout 5cbb369e32bd21b10ff374f87369838788c601e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:57: warning: implicit conversion from 'enum scan_direction_class' to 'enum dm_rotation_angle' [-Wenum-conversion]
    1414 |                                 mode_lib->vba.SourceScan[k],
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1744:67: warning: implicit conversion from 'enum scan_direction_class' to 'enum dm_rotation_angle' [-Wenum-conversion]
    1744 |                         && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
         |                                           ~~~~~~~~~~~~~~~~~~~~~~~~^~~
   At top level:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:33:27: warning: 'NumberOfStates' defined but not used [-Wunused-const-variable=]
      33 | static const unsigned int NumberOfStates = DC__VOLTAGE_STATES;
         |                           ^~~~~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:393:6: warning: no previous prototype for 'dml32_CalculatedoublePipeDPPCLKAndSCLThroughput' [-Wmissing-prototypes]
     393 | void dml32_CalculatedoublePipeDPPCLKAndSCLThroughput(
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c: In function 'dml32_CalculateDCCConfiguration':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5484:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5484 |                         RequestLuma = REQ_256Bytes;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5487:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5487 |                         RequestLuma = REQ_128BytesNonContiguous;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5489:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5489 |                         RequestLuma = REQ_128BytesContiguous;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5492:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5492 |                         RequestChroma = REQ_256Bytes;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5495:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5495 |                         RequestChroma = REQ_128BytesNonContiguous;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5497:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5497 |                         RequestChroma = REQ_128BytesContiguous;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5501:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5501 |                         RequestLuma = REQ_256Bytes;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5503:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5503 |                         RequestLuma = REQ_128BytesNonContiguous;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5505:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5505 |                         RequestLuma = REQ_128BytesContiguous;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5508:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5508 |                         RequestChroma = REQ_256Bytes;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5510:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5510 |                         RequestChroma = REQ_128BytesNonContiguous;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5512:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5512 |                         RequestChroma = REQ_128BytesContiguous;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5516:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5516 |                         RequestLuma = REQ_256Bytes;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5518:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5518 |                         RequestLuma = REQ_128BytesNonContiguous;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5520:37: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5520 |                         RequestLuma = REQ_128BytesContiguous;
         |                                     ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5523:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5523 |                         RequestChroma = REQ_256Bytes;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5525:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5525 |                         RequestChroma = REQ_128BytesNonContiguous;
         |                                       ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5527:39: warning: implicit conversion from 'enum <anonymous>' to 'enum RequestType' [-Wenum-conversion]
    5527 |                         RequestChroma = REQ_128BytesContiguous;
         |                                       ^


vim +1414 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c

  1124	
  1125			v->VStartupLines = v->VStartupLines + 1;
  1126	
  1127			if (v->VStartupLines > v->MaximumMaxVStartupLines) {
  1128	#ifdef __DML_VBA_DEBUG__
  1129				dml_print("DML::%s: Vstartup exceeds max vstartup, exiting loop\n", __func__);
  1130	#endif
  1131				break; // VBA_DELTA: Implementation divergence! Gabe is *still* iterating across prefetch modes which we don't care to do
  1132			}
  1133			iteration++;
  1134			if (iteration > 2500) {
  1135	#ifdef __DML_VBA_DEBUG__
  1136				dml_print("DML::%s: too many errors, exit now\n", __func__);
  1137				assert(0);
  1138	#endif
  1139			}
  1140		} while (!(v->PrefetchAndImmediateFlipSupported || NextPrefetchMode > mode_lib->vba.MaxPrefetchMode));
  1141	
  1142	
  1143		if (v->VStartupLines <= v->MaximumMaxVStartupLines) {
  1144	#ifdef __DML_VBA_DEBUG__
  1145			dml_print("DML::%s: Good, Prefetch and flip scheduling found solution at VStartupLines=%d\n", __func__, locals->VStartupLines-1);
  1146	#endif
  1147		}
  1148	
  1149	
  1150		//Watermarks and NB P-State/DRAM Clock Change Support
  1151		{
  1152			SOCParametersList mmSOCParameters;
  1153			enum clock_change_support dummy_dramchange_support;
  1154			enum dm_fclock_change_support dummy_fclkchange_support;
  1155			bool dummy_USRRetrainingSupport;
  1156	
  1157			mmSOCParameters.UrgentLatency = v->UrgentLatency;
  1158			mmSOCParameters.ExtraLatency = v->UrgentExtraLatency;
  1159			mmSOCParameters.WritebackLatency = mode_lib->vba.WritebackLatency;
  1160			mmSOCParameters.DRAMClockChangeLatency = mode_lib->vba.DRAMClockChangeLatency;
  1161			mmSOCParameters.FCLKChangeLatency = mode_lib->vba.FCLKChangeLatency;
  1162			mmSOCParameters.SRExitTime = mode_lib->vba.SRExitTime;
  1163			mmSOCParameters.SREnterPlusExitTime = mode_lib->vba.SREnterPlusExitTime;
  1164			mmSOCParameters.SRExitZ8Time = mode_lib->vba.SRExitZ8Time;
  1165			mmSOCParameters.SREnterPlusExitZ8Time = mode_lib->vba.SREnterPlusExitZ8Time;
  1166			mmSOCParameters.USRRetrainingLatency = mode_lib->vba.USRRetrainingLatency;
  1167			mmSOCParameters.SMNLatency = mode_lib->vba.SMNLatency;
  1168	
  1169			dml32_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(
  1170				mode_lib->vba.USRRetrainingRequiredFinal,
  1171				mode_lib->vba.UsesMALLForPStateChange,
  1172				mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb],
  1173				mode_lib->vba.NumberOfActiveSurfaces,
  1174				mode_lib->vba.MaxLineBufferLines,
  1175				mode_lib->vba.LineBufferSizeFinal,
  1176				mode_lib->vba.WritebackInterfaceBufferSize,
  1177				mode_lib->vba.DCFCLK,
  1178				mode_lib->vba.ReturnBW,
  1179				mode_lib->vba.SynchronizeTimingsFinal,
  1180				mode_lib->vba.SynchronizeDRRDisplaysForUCLKPStateChangeFinal,
  1181				mode_lib->vba.DRRDisplay,
  1182				v->dpte_group_bytes,
  1183				v->meta_row_height,
  1184				v->meta_row_height_chroma,
  1185				mmSOCParameters,
  1186				mode_lib->vba.WritebackChunkSize,
  1187				mode_lib->vba.SOCCLK,
  1188				v->DCFCLKDeepSleep,
  1189				mode_lib->vba.DETBufferSizeY,
  1190				mode_lib->vba.DETBufferSizeC,
  1191				mode_lib->vba.SwathHeightY,
  1192				mode_lib->vba.SwathHeightC,
  1193				mode_lib->vba.LBBitPerPixel,
  1194				v->SwathWidthY,
  1195				v->SwathWidthC,
  1196				mode_lib->vba.HRatio,
  1197				mode_lib->vba.HRatioChroma,
  1198				mode_lib->vba.vtaps,
  1199				mode_lib->vba.VTAPsChroma,
  1200				mode_lib->vba.VRatio,
  1201				mode_lib->vba.VRatioChroma,
  1202				mode_lib->vba.HTotal,
  1203				mode_lib->vba.VTotal,
  1204				mode_lib->vba.VActive,
  1205				mode_lib->vba.PixelClock,
  1206				mode_lib->vba.BlendingAndTiming,
  1207				mode_lib->vba.DPPPerPlane,
  1208				v->BytePerPixelDETY,
  1209				v->BytePerPixelDETC,
  1210				v->DSTXAfterScaler,
  1211				v->DSTYAfterScaler,
  1212				mode_lib->vba.WritebackEnable,
  1213				mode_lib->vba.WritebackPixelFormat,
  1214				mode_lib->vba.WritebackDestinationWidth,
  1215				mode_lib->vba.WritebackDestinationHeight,
  1216				mode_lib->vba.WritebackSourceHeight,
  1217				v->UnboundedRequestEnabled,
  1218				v->CompressedBufferSizeInkByte,
  1219	
  1220				/* Output */
  1221				&v->Watermark,
  1222				&dummy_dramchange_support,
  1223				v->MaxActiveDRAMClockChangeLatencySupported,
  1224				v->SubViewportLinesNeededInMALL,
  1225				&dummy_fclkchange_support,
  1226				&v->MinActiveFCLKChangeLatencySupported,
  1227				&dummy_USRRetrainingSupport,
  1228				mode_lib->vba.ActiveDRAMClockChangeLatencyMargin);
  1229	
  1230			/* DCN32 has a new struct Watermarks (typedef) which is used to store
  1231			 * calculated WM values. Copy over values from struct to vba varaibles
  1232			 * to ensure that the DCN32 getters return the correct value.
  1233			 */
  1234			v->UrgentWatermark = v->Watermark.UrgentWatermark;
  1235			v->WritebackUrgentWatermark = v->Watermark.WritebackUrgentWatermark;
  1236			v->DRAMClockChangeWatermark = v->Watermark.DRAMClockChangeWatermark;
  1237			v->WritebackDRAMClockChangeWatermark = v->Watermark.WritebackDRAMClockChangeWatermark;
  1238			v->StutterExitWatermark = v->Watermark.StutterExitWatermark;
  1239			v->StutterEnterPlusExitWatermark = v->Watermark.StutterEnterPlusExitWatermark;
  1240			v->Z8StutterExitWatermark = v->Watermark.Z8StutterExitWatermark;
  1241			v->Z8StutterEnterPlusExitWatermark = v->Watermark.Z8StutterEnterPlusExitWatermark;
  1242	
  1243			for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
  1244				if (mode_lib->vba.WritebackEnable[k] == true) {
  1245					v->WritebackAllowDRAMClockChangeEndPosition[k] = dml_max(0,
  1246							v->VStartup[k] * mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]
  1247									- v->Watermark.WritebackDRAMClockChangeWatermark);
  1248					v->WritebackAllowFCLKChangeEndPosition[k] = dml_max(0,
  1249							v->VStartup[k] * mode_lib->vba.HTotal[k] / mode_lib->vba.PixelClock[k]
  1250									- v->Watermark.WritebackFCLKChangeWatermark);
  1251				} else {
  1252					v->WritebackAllowDRAMClockChangeEndPosition[k] = 0;
  1253					v->WritebackAllowFCLKChangeEndPosition[k] = 0;
  1254				}
  1255			}
  1256		}
  1257	
  1258		//Display Pipeline Delivery Time in Prefetch, Groups
  1259		dml32_CalculatePixelDeliveryTimes(
  1260				mode_lib->vba.NumberOfActiveSurfaces,
  1261				mode_lib->vba.VRatio,
  1262				mode_lib->vba.VRatioChroma,
  1263				v->VRatioPrefetchY,
  1264				v->VRatioPrefetchC,
  1265				v->swath_width_luma_ub,
  1266				v->swath_width_chroma_ub,
  1267				mode_lib->vba.DPPPerPlane,
  1268				mode_lib->vba.HRatio,
  1269				mode_lib->vba.HRatioChroma,
  1270				mode_lib->vba.PixelClock,
  1271				v->PSCL_THROUGHPUT_LUMA,
  1272				v->PSCL_THROUGHPUT_CHROMA,
  1273				mode_lib->vba.DPPCLK,
  1274				v->BytePerPixelC,
  1275				mode_lib->vba.SourceRotation,
  1276				mode_lib->vba.NumberOfCursors,
  1277				mode_lib->vba.CursorWidth,
  1278				mode_lib->vba.CursorBPP,
  1279				v->BlockWidth256BytesY,
  1280				v->BlockHeight256BytesY,
  1281				v->BlockWidth256BytesC,
  1282				v->BlockHeight256BytesC,
  1283	
  1284				/* Output */
  1285				v->DisplayPipeLineDeliveryTimeLuma,
  1286				v->DisplayPipeLineDeliveryTimeChroma,
  1287				v->DisplayPipeLineDeliveryTimeLumaPrefetch,
  1288				v->DisplayPipeLineDeliveryTimeChromaPrefetch,
  1289				v->DisplayPipeRequestDeliveryTimeLuma,
  1290				v->DisplayPipeRequestDeliveryTimeChroma,
  1291				v->DisplayPipeRequestDeliveryTimeLumaPrefetch,
  1292				v->DisplayPipeRequestDeliveryTimeChromaPrefetch,
  1293				v->CursorRequestDeliveryTime,
  1294				v->CursorRequestDeliveryTimePrefetch);
  1295	
  1296		dml32_CalculateMetaAndPTETimes(v->Use_One_Row_For_Frame,
  1297				mode_lib->vba.NumberOfActiveSurfaces,
  1298				mode_lib->vba.GPUVMEnable,
  1299				mode_lib->vba.MetaChunkSize,
  1300				mode_lib->vba.MinMetaChunkSizeBytes,
  1301				mode_lib->vba.HTotal,
  1302				mode_lib->vba.VRatio,
  1303				mode_lib->vba.VRatioChroma,
  1304				v->DestinationLinesToRequestRowInVBlank,
  1305				v->DestinationLinesToRequestRowInImmediateFlip,
  1306				mode_lib->vba.DCCEnable,
  1307				mode_lib->vba.PixelClock,
  1308				v->BytePerPixelY,
  1309				v->BytePerPixelC,
  1310				mode_lib->vba.SourceRotation,
  1311				v->dpte_row_height,
  1312				v->dpte_row_height_chroma,
  1313				v->meta_row_width,
  1314				v->meta_row_width_chroma,
  1315				v->meta_row_height,
  1316				v->meta_row_height_chroma,
  1317				v->meta_req_width,
  1318				v->meta_req_width_chroma,
  1319				v->meta_req_height,
  1320				v->meta_req_height_chroma,
  1321				v->dpte_group_bytes,
  1322				v->PTERequestSizeY,
  1323				v->PTERequestSizeC,
  1324				v->PixelPTEReqWidthY,
  1325				v->PixelPTEReqHeightY,
  1326				v->PixelPTEReqWidthC,
  1327				v->PixelPTEReqHeightC,
  1328				v->dpte_row_width_luma_ub,
  1329				v->dpte_row_width_chroma_ub,
  1330	
  1331				/* Output */
  1332				v->DST_Y_PER_PTE_ROW_NOM_L,
  1333				v->DST_Y_PER_PTE_ROW_NOM_C,
  1334				v->DST_Y_PER_META_ROW_NOM_L,
  1335				v->DST_Y_PER_META_ROW_NOM_C,
  1336				v->TimePerMetaChunkNominal,
  1337				v->TimePerChromaMetaChunkNominal,
  1338				v->TimePerMetaChunkVBlank,
  1339				v->TimePerChromaMetaChunkVBlank,
  1340				v->TimePerMetaChunkFlip,
  1341				v->TimePerChromaMetaChunkFlip,
  1342				v->time_per_pte_group_nom_luma,
  1343				v->time_per_pte_group_vblank_luma,
  1344				v->time_per_pte_group_flip_luma,
  1345				v->time_per_pte_group_nom_chroma,
  1346				v->time_per_pte_group_vblank_chroma,
  1347				v->time_per_pte_group_flip_chroma);
  1348	
  1349		dml32_CalculateVMGroupAndRequestTimes(
  1350				mode_lib->vba.NumberOfActiveSurfaces,
  1351				mode_lib->vba.GPUVMEnable,
  1352				mode_lib->vba.GPUVMMaxPageTableLevels,
  1353				mode_lib->vba.HTotal,
  1354				v->BytePerPixelC,
  1355				v->DestinationLinesToRequestVMInVBlank,
  1356				v->DestinationLinesToRequestVMInImmediateFlip,
  1357				mode_lib->vba.DCCEnable,
  1358				mode_lib->vba.PixelClock,
  1359				v->dpte_row_width_luma_ub,
  1360				v->dpte_row_width_chroma_ub,
  1361				v->vm_group_bytes,
  1362				v->dpde0_bytes_per_frame_ub_l,
  1363				v->dpde0_bytes_per_frame_ub_c,
  1364				v->meta_pte_bytes_per_frame_ub_l,
  1365				v->meta_pte_bytes_per_frame_ub_c,
  1366	
  1367				/* Output */
  1368				v->TimePerVMGroupVBlank,
  1369				v->TimePerVMGroupFlip,
  1370				v->TimePerVMRequestVBlank,
  1371				v->TimePerVMRequestFlip);
  1372	
  1373		// Min TTUVBlank
  1374		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
  1375			if (mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb] == 0) {
  1376				v->MinTTUVBlank[k] = dml_max4(v->Watermark.DRAMClockChangeWatermark,
  1377						v->Watermark.FCLKChangeWatermark, v->Watermark.StutterEnterPlusExitWatermark,
  1378						v->Watermark.UrgentWatermark);
  1379			} else if (mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb]
  1380					== 1) {
  1381				v->MinTTUVBlank[k] = dml_max3(v->Watermark.FCLKChangeWatermark,
  1382						v->Watermark.StutterEnterPlusExitWatermark, v->Watermark.UrgentWatermark);
  1383			} else if (mode_lib->vba.PrefetchModePerState[mode_lib->vba.VoltageLevel][mode_lib->vba.maxMpcComb]
  1384					== 2) {
  1385				v->MinTTUVBlank[k] = dml_max(v->Watermark.StutterEnterPlusExitWatermark,
  1386						v->Watermark.UrgentWatermark);
  1387			} else {
  1388				v->MinTTUVBlank[k] = v->Watermark.UrgentWatermark;
  1389			}
  1390			if (!mode_lib->vba.DynamicMetadataEnable[k])
  1391				v->MinTTUVBlank[k] = mode_lib->vba.TCalc + v->MinTTUVBlank[k];
  1392		}
  1393	
  1394		// DCC Configuration
  1395		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
  1396	#ifdef __DML_VBA_DEBUG__
  1397			dml_print("DML::%s: Calculate DCC configuration for surface k=%d\n", __func__, k);
  1398	#endif
  1399			dml32_CalculateDCCConfiguration(
  1400					mode_lib->vba.DCCEnable[k],
  1401					mode_lib->vba.DCCProgrammingAssumesScanDirectionUnknownFinal,
  1402					mode_lib->vba.SourcePixelFormat[k], mode_lib->vba.SurfaceWidthY[k],
  1403					mode_lib->vba.SurfaceWidthC[k],
  1404					mode_lib->vba.SurfaceHeightY[k],
  1405					mode_lib->vba.SurfaceHeightC[k],
  1406					mode_lib->vba.nomDETInKByte,
  1407					v->BlockHeight256BytesY[k],
  1408					v->BlockHeight256BytesC[k],
  1409					mode_lib->vba.SurfaceTiling[k],
  1410					v->BytePerPixelY[k],
  1411					v->BytePerPixelC[k],
  1412					v->BytePerPixelDETY[k],
  1413					v->BytePerPixelDETC[k],
> 1414					mode_lib->vba.SourceScan[k],
  1415					/* Output */
  1416					&v->DCCYMaxUncompressedBlock[k],
  1417					&v->DCCCMaxUncompressedBlock[k],
  1418					&v->DCCYMaxCompressedBlock[k],
  1419					&v->DCCCMaxCompressedBlock[k],
  1420					&v->DCCYIndependentBlock[k],
  1421					&v->DCCCIndependentBlock[k]);
  1422		}
  1423	
  1424		// VStartup Adjustment
  1425		for (k = 0; k < mode_lib->vba.NumberOfActiveSurfaces; ++k) {
  1426			bool isInterlaceTiming;
  1427			double Tvstartup_margin = (v->MaxVStartupLines[k] - v->VStartup[k]) * mode_lib->vba.HTotal[k]
  1428					/ mode_lib->vba.PixelClock[k];
  1429	#ifdef __DML_VBA_DEBUG__
  1430			dml_print("DML::%s: k=%d, MinTTUVBlank = %f (before vstartup margin)\n", __func__, k,
  1431					v->MinTTUVBlank[k]);
  1432	#endif
  1433	
  1434			v->MinTTUVBlank[k] = v->MinTTUVBlank[k] + Tvstartup_margin;
  1435	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
